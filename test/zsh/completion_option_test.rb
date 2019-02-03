require_relative '../test_helper'
# require_relative 'test_commands/plain_subcommand'
require_relative 'test_commands/thor_test'

module Zsh
  module CompletionOptionTest
    class Subcommand1 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option

      def withopts
        puts 'with options'
      end
    end
    class Subcommand1Boolean < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option,
             type: :boolean

      def withopts
        puts 'with options'
      end
    end
    class Subcommand2 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option, completion: "a completion"
      def withopts
        puts 'with options'
      end
    end
    class Subcommand3 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option, desc: "a description"
      def withopts
        puts 'with options'
      end
    end
    class Subcommand4 < ThorTest
      desc 'withopts', 'subcommand that takes options'
      option :an_option, banner: "a banner"
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

class CompletionOptionTest < Minitest::Test
  def setup
    Fylla.load('options')
  end

  def test_options_no_description
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
      Zsh::CompletionOptionTest::Subcommand1.start(ARGV)
    end
  end

  def test_options_no_description_boolean
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionOptionTest::Subcommand1Boolean.start(ARGV)
    end
  end

  def test_options_completion_description
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[a completion]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionOptionTest::Subcommand2.start(ARGV)
    end
  end

  def test_options_description_description
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[a description]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionOptionTest::Subcommand3.start(ARGV)
    end
  end

  def test_options_banner_description
    expected = <<~'HERE'
      function _options_withopts {
        _arguments \
          "--an_option=[a banner]" \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: :_commands" \
          "*::arg:->args"/.
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionOptionTest::Subcommand4.start(ARGV)
    end
  end
end
