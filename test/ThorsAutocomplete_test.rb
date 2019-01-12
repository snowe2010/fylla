require_relative "test_helper"
require_relative 'cli'

class ThorsAutocompleteTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ThorsAutocomplete::VERSION
  end

  def test_cli_start_noargs
    ARGV.clear
    assert_output(/Commands/) {CLI.start(ARGV)}
  end

  def test_cli_start_subcommand_plain
    ARGV.clear
    ARGV << "sub"
    assert_output(/ThorsAutocomplete_test.rb sub help \[COMMAND\]/) {CLI.start(ARGV)}
  end

  def test_cli_start_subcommand_noopts
    ARGV.clear
    ARGV << "sub"
    ARGV << "noopts"
    assert_output("noopts\n") {CLI.start(ARGV)}
  end

end
