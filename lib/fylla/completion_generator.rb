require_relative 'parsed_command'
require_relative 'parsed_subcommand'
require 'erb'

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
        def zsh_completion(executable_name)
          command = create_command_map commands, subcommand_classes

          def recurse(commands, context = '', class_options = [], executable_name = '')
            builder = ''
            commands.each do |command|
              context_name = "#{context}#{command.name.nil? || command.name.empty? ? '' : "_#{command.name}"}"
              result = if command.is_a? ParsedSubcommand
                         class_options = (class_options + command.class_options).uniq
                         builder += recurse(command.commands, context_name, class_options, executable_name)
                         create_completion_string(subcommand_template_file, binding)
                       else
                         create_completion_string(command_template_file, binding)
                       end
              builder += result
            end
            builder
          end

          # template = ERB.new(help_template, nil, '-<>')
          builder = recurse [command], executable_name
          completion = "#compdef _#{executable_name} #{executable_name}\n"
          completion += builder
          completion
        end

        private

        def recursively_find_commands(command_map, subcommand_map)
          map = Hash[command_map.map { |k, v| [v, subcommand_map[k]] }]
          map.map do |command, subcommand_class|
            if subcommand_class.nil?
              ancestor_name = if command.respond_to? :ancestor_name
                                command.ancestor_name
                              end
              ParsedCommand.new(ancestor_name, command.description, command.name, command.options.values)
            else
              commands = recursively_find_commands subcommand_class.commands, subcommand_class.subcommand_classes
              ParsedSubcommand.new(command.name, command.description, commands, subcommand_class.class_options.values)
            end
          end
        end

        def create_command_map(command_map, subcommand_map)
          command_map = recursively_find_commands command_map, subcommand_map
          ParsedSubcommand.new(nil, '', command_map, [])
        end

        def create_completion_string(template, bind)
          template = ERB.new(template, nil, '-<>')
          template.result(bind)
        end

        def command_template_file
          read_template 'command'
        end

        def subcommand_template_file
          read_template 'subcommand'
        end

        def help_template_file
          read_template 'help.erb'
        end

        def read_template(template_name)
          File.read(File.join(__dir__, "erb_templates/#{template_name}.erb"))
        end
      end
    end
  end
end
