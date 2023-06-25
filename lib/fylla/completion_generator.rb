require_relative "parsed_option"
require_relative "parsed_command"
require_relative "parsed_subcommand"
require "erb"

module Fylla
  module Thor
    #
    # module for prepending into +Thor+
    # inserts methods into Thor that allow generating completion scripts
    module CompletionGenerator
      def self.prepended(base)
        base.singleton_class.prepend(ClassMethods)
      end

      #
      # Contains the methods +zsh_completion+
      module ClassMethods
        #
        # Generates a zsh _[executable_name] completion
        # script for the entire Thor application
        #
        # @param executable_name [String]
        #   the name of the executable to generate the script for
        def zsh_completion(executable_name)
          @executable_name = executable_name
          command = create_command_map all_commands, subcommand_classes

          builder = map_to_completion_string [command]
          completion = "#compdef _#{executable_name} #{executable_name}\n"
          completion += builder
          completion += %(_#{executable_name} "$@")
          completion
        end

        #
        # Generates a bash _[executable_name] completion
        # script for the entire Thor application
        #
        # @param executable_name [String]
        #   the name of the executable to generate the script for
        def bash_completion(executable_name)
          @executable_name = executable_name
          command = create_command_map all_commands, subcommand_classes

          builder = map_to_completion_string [command], style: :bash
          completion = ""
          completion += builder
          completion += "complete -F _#{executable_name} #{executable_name}\n"
          completion
        end

        private

        # Takes a list of [ParsedCommand]s and [ParsedSubcommand]s
        # and converts them into completion strings, to be combined
        # together into one completion script
        #
        # @param style [Symbol] style of completions to generate
        #   defaults to :zsh
        # @param commands [List<Thor::Command>]
        #   list of [Thor::Command]s
        # @param context [String] the current command context
        #   this is essentially a breadcrumb of our current
        #   command path:
        #     e.g. "exe sub1 sub2 sub3 --help" maps to a context of
        #          "_sub1_sub2_sub3"
        # @param class_options [List<Thor::Option>]
        #   a list of global or class level options for the current context
        def map_to_completion_string(commands,
                                     context: "",
                                     class_options: [],
                                     style: :zsh)
          builder = ""
          commands.each do |command|
            context_name = generate_context_name(context, command)
            result = generate_completion_string(command, class_options, context_name, style)
            builder += result
          end
          builder
        end

        # Generate a context name based off of
        # the current context and the current command
        #
        # @param context [String] the current context
        # @param command [Thor::Command]
        #   current command we are generating documentation for
        def generate_context_name(context, command)
          command_name = if command.name.nil? || command.name.empty?
                           ""
                         else
                           "_#{command.name}"
                         end
          "#{context}#{command_name}"
        end

        def generate_completion_string(command, class_options, context_name, style)
          builder = ""
          if command.is_a? ParsedSubcommand
            class_options = parse_options((class_options + command.class_options).uniq)
            builder += map_to_completion_string(command.commands,
                                                context: context_name,
                                                class_options: class_options,
                                                style: style)

            builder += create_completion_string(read_template(style, :subcommand), binding)
          else
            builder += create_completion_string(read_template(style, :command), binding)
          end
          builder
        end

        # Recursively generate a command map based off
        # of the commands and subcommands passed in.
        #
        # The [command_map] is a map of [String]s to [Thor::Command] objects,
        # while the [subcommand_map] is a map of [String]s to [Thor] classes,
        # usually your own CLI classes that subclass [Thor]
        #
        # @param command_map [Hash<String, Thor::Command>]
        #   a map to recursively generate a completion layout
        # @param subcommand_map [Hash<String, Class < Thor>]
        #   a map indicating the subcommands and their respective classes
        def recursively_find_commands(command_map, subcommand_map)
          map = Hash[command_map.map { |k, v| [v, subcommand_map[k]] }]
          map.map do |command, subcommand_class|
            if subcommand_class.nil?
              ancestor_name = command.ancestor_name if command.respond_to? :ancestor_name
              options = parse_options(command.options.values)
              ParsedCommand.new(ancestor_name, command.description, command.name, options)
            else
              commands = recursively_find_commands subcommand_class.commands,
                                                   subcommand_class.subcommand_classes
              ParsedSubcommand.new(command.name, command.description, commands,
                                   subcommand_class.class_options.values)
            end
          end
        end

        # Top level method to begin the recursive map generation
        # This is needed because we don't have a 'top' level
        # command to wrap everything under.
        #
        # This simplifies the rest of the code.
        #
        # (see #recursively_find_commands) for more documentation
        def create_command_map(command_map, subcommand_map)
          command_map = recursively_find_commands command_map, subcommand_map
          ParsedSubcommand.new(nil, "", command_map, class_options.values)
        end

        # Helper method to load an [ERB] template
        # and generate the corresponding [String]
        #
        # @param template [String] an ERB template
        # @param bind [Binding] a binding to a context
        def create_completion_string(template, bind)
          template = ERB.new(template, trim_mode: "-<>")
          template.result(bind)
        end

        # Helper method to read an [ERB] template
        # from a file and return it as a [String]
        #
        # @param name [Symbol] type of template to retrieve
        #   can be either :subcommand or :command
        # @param style [Symbol] style of template to retrieve
        #   can be either :zsh or :bash
        # @return [String] template string retrieved from erb file
        def read_template(style, name)
          style = style.is_a?(Symbol) ? style.to_s : style
          name = name.is_a?(Symbol) ? name.to_s : name
          erb_path = "erb_templates/#{style}/#{name}.erb"
          File.read(File.join(__dir__, erb_path))
        end

        def parse_options(options)
          options.map do |opt|
            description = opt.completion || opt.description || opt.banner || opt.name.to_s.upcase
            ParsedOption.new(opt.name, description, opt.aliases, opt.enum, opt.filter, opt.type)
          end
        end
      end
    end
  end
end
