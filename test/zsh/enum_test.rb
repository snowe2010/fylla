require_relative '../test_helper'
# require_relative 'test_commands/plain_subcommand'
require_relative 'test_commands/thor_test'

module Zsh
  module EnumTest
    class Main < ThorTest
      desc 'command', 'command'
      option :test,
             enum: %w(enum1 enum2 enum3)
      def command; end
      desc 'command2', 'command2'
      option :test,
             type: :array,
             enum: %w(enum1 enum2 enum3)
      def command2; end
      desc 'command3', 'command3'
      option :test,
             type: :array,
             enum: %w(enum1 enum2 enum3),
             fylla: { filter: false }
      def command3; end
      desc 'command4', 'command4'
      option :test
      def command4; end
    end
  end
end

class EnumTest < Minitest::Test
  def setup
    Fylla.load('options')
  end

  # default type is string
  def test_default_enum_outputs
    expected = <<~'HERE'
      function _options_command {
        _arguments \
          "--test=[TEST]: :(enum1 enum2 enum3)" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::EnumTest::Main.start(ARGV)
    end
  end

  def test_array_enum_outputs
    expected = <<~'HERE'
      function _options_command2 {
        _arguments \
          "--test=[one two three]: :_values -s , 'options' enum1 enum2 enum3" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::EnumTest::Main.start(ARGV)
    end
  end

  def test_array_enum_outputs_filter_off
    expected = <<~'HERE'
      function _options_command3 {
        _arguments \
          "--test=[one two three]: :_sequence -d compadd - enum1 enum2 enum3" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::EnumTest::Main.start(ARGV)
    end
  end

  def test_no_enum_provided
    expected = <<~'HERE'
      function _options_command4 {
        _arguments \
          "--test=[TEST]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::EnumTest::Main.start(ARGV)
    end
  end
end
