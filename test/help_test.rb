require_relative "test_helper"
require_relative "bash/bash_clis/cli"

class HelpTest < Minitest::Test
  def setup
    Fylla.load("test")
  end

  def test_bash_single_subcommand
    ARGV.clear
    ARGV << "help"
    # expected = SUBCOMMAND
    # assert_output(expected) do
    Bash::CLI::SubcommandWithNestedSubcommandsAndOptions.start(ARGV)
    # end
  end

  def test_bash_single_subcommanda
    ARGV.clear
    ARGV << "plain" << "-h"
    # expected = SUBCOMMAND
    # assert_output(expected) do
    Bash::CLI::SubcommandWithNestedSubcommandsAndOptions.start(ARGV)
    # end
  end
end
