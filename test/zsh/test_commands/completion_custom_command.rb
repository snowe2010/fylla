require "thor_test"

module Zsh
  module CompletionCustomCommand
    class Main < ThorTest
      desc "sub", "a subcommand"
      completion "testing that this workds..... "
      subcommand "sub", Subcommand
    end
  end
end
