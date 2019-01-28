require_relative 'thor_test'

module Zsh
  module PlainSubcommands
    class Subcommand < ThorTest
      desc 'noopts', 'subcommand that takes no options'
      def noopts
        puts 'noopts'
      end
    end

    class Main < ThorTest
      desc 'sub', 'a subcommand'
      subcommand 'sub', Subcommand
    end
  end
end