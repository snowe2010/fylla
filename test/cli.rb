require 'thor'

module Zsh
  module CLI
    class Subcommand < Thor
      include Thor::Base
      desc 'noopts', 'subcommand that takes no options'

      def noopts
        puts 'noopts'
      end
    end

    class Main < Thor
      include Thor::Base
      desc 'sub', 'a subcommand'
      subcommand 'sub', Subcommand

      desc 'generate_completions', 'generate completions'

      def generate_completions
        puts Fylla.zsh_completion(self)
      end
    end
  end
end