require_relative '../test_helper'
# require_relative 'test_commands/plain_subcommand'
require_relative 'test_commands/thor_test'

module Zsh
  module ListTest
    class Main < ThorTest
      desc 'command', 'command'
      option :test,
             enum: %w(enum1 enum2 enum3)
      def completion; end
      desc 'command2', 'command2'
      option :test
      def command2; end
    end
  end
end

class ListTest < Minitest::Test
  def setup
    Fylla.load('options')
  end

  def test_enum_outputs
    expected = <<~'HERE'
      function _options_completion {
        _arguments \
          "--test=[TEST]:*: :(enum1 enum2 enum3)" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::ListTest::Main.start(ARGV)
    end
  end

  def test_no_enum_provided
    expected = <<~'HERE'
      function _options_command2 {
        _arguments \
          "--test[TEST]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::ListTest::Main.start(ARGV)
    end
  end
end
