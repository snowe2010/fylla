require_relative 'test_helper'
require_relative 'cli'

class FyllaTest < Minitest::Test
  def setup
    ARGV.clear
    Fylla.load('test')
  end

  def test_version_number
    refute_nil ::Fylla::VERSION
  end

  def test_cli_start_no_args
    assert_output(/Commands/) do
      CLI.start(ARGV)
    end
  end

  def test_cli_start_subcommand_plain
    ARGV << 'sub'
    assert_output(/
      Commands:\n
      .* \D+?\shelp\s\[COMMAND\].*?\n
      .* \D+?\snoopts\s.*?
    /x) do
      CLI.start(ARGV)
    end
  end

  def test_cli_start_subcommand_noopts
    ARGV << 'sub'
    ARGV << 'noopts'
    assert_output("noopts\n") do
      CLI.start(ARGV)
    end
  end
end
