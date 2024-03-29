require_relative "../test_helper"
# require_relative 'test_commands/plain_subcommand'
require_relative "test_commands/thor_test"

module Zsh
  module WeirdDescriptionsTest
    class Main < ThorTest
      desc "singlequote", "Description with single quote '"
      option :test, fylla: { completion: "option with single quote '" }
      def singlequote; end
      desc "doublequote", 'Description with double quote "'
      option :test, fylla: { completion: 'option with double quote "' }
      def doublequote; end
    end
  end
end

class WeirdDescriptionsTest < Minitest::Test
  def setup
    Fylla.load("options")
  end

  def test_single_quote_escape
    expected = <<~'HERE'
      'singlequote:Description with single quote '"'"''
    HERE

    ARGV.clear
    ARGV << "generate_completions"
    assert_output(matches(expected)) do
      Zsh::WeirdDescriptionsTest::Main.start(ARGV)
    end
  end

  def test_double_quote_escape
    expected = <<~'HERE'
      "--test=[option with double quote \"]" \
    HERE

    ARGV.clear
    ARGV << "generate_completions"
    assert_output(matches(expected)) do
      Zsh::WeirdDescriptionsTest::Main.start(ARGV)
    end
  end
end
