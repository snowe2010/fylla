module Bash
  module CLI
    class ThorHelper < Thor
      desc 'generate', 'generate completions'

      def generate
        puts Fylla.bash_completion(self)
      end
    end

    class Subcommand < ThorHelper
      desc 'plain', 'plain subcommand'

      def plain
        puts 'plain complete'
      end
    end

    class SubcommandWithOptions < ThorHelper
      option :opt1
      desc 'plain', 'plain subcommand'

      def plain
        puts 'plain complete'
      end
    end

    class SubcommandWithNestedSubcommandsAndOptions < ThorHelper
      class_option :class_opt,
                   desc: 'a global option'

      option :opt1
      desc 'plain', 'plain subcommand'

      def plain
        puts 'plain complete'
      end

      desc 'subcommand', 'nested subcommand'
      subcommand 'subcommand', Subcommand

      desc 'subcommand2', 'nested subcommand'
      subcommand 'subcommand2', SubcommandWithOptions
    end
  end
end