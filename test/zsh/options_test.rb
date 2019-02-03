require_relative '../test_helper'
# require_relative 'test_commands/plain_subcommand'
require_relative 'test_commands/thor_test'

module Zsh
  module OptionsTest
    class Subcommand1 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option

      def withopts
        puts 'with options'
      end
    end
    class Subcommand2 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option, aliases: %w(a)
      def withopts
        puts 'with options'
      end
    end
    class Subcommand3 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option, aliases: %w(a b)
      def withopts
        puts 'with options'
      end
    end

    class Main < ThorTest
      desc 'sub', 'a subcommand'
      subcommand 'sub', Subcommand1
    end
  end
end

class OptionsTest < Minitest::Test
  def setup
    Fylla.load('options')
  end

  def test_options_no_aliases
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[AN_OPTION]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::OptionsTest::Subcommand1.start(ARGV)
    end
  end

  def test_options_one_alias
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[AN_OPTION]" \
          "-a=[AN_OPTION]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::OptionsTest::Subcommand2.start(ARGV)
    end
  end

  def test_options_multiple_aliases
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[AN_OPTION]" \
          "-a=[AN_OPTION]" \
          "-b=[AN_OPTION]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::OptionsTest::Subcommand3.start(ARGV)
    end
  end
end
