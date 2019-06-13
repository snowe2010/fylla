require_relative '../test_helper'
# require_relative 'test_commands/plain_subcommand'
require_relative 'test_commands/thor_test'

module Zsh
  module CompletionFlagTest
    class Main < ThorTest
      desc 'completion', 'use completion flag for description'
      option :test,
             fylla: { completion: "completion" },
             desc: "shouldn't be used if completion is present",
             banner: "shouldn't be used if completion is present"
      def completion; end
      desc 'desc', 'use description flag for description'
      option :test,
             desc: "desc",
             banner: "shouldn't be used if desc is present"
      def desc; end
      desc 'banner', 'use banner flag for description'
      option :test, banner: "banner"
      def banner; end
    end
  end
end

class CompletionFlagTest < Minitest::Test
  def setup
    Fylla.load('options')
  end

  def test_completion_flag_provides_alternate_description
    expected = <<~'HERE'
      function _options_completion {
        _arguments \
          "--test[completion]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionFlagTest::Main.start(ARGV)
    end
  end

  def test_desc_flag_provides_alternate_description
    expected = <<~'HERE'
      function _options_desc {
        _arguments \
          "--test[desc]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionFlagTest::Main.start(ARGV)
    end
  end

  def test_banner_flag_if_no_other_provided
    expected = <<~'HERE'
      function _options_banner {
        _arguments \
          "--test[banner]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(matches(expected)) do
      Zsh::CompletionFlagTest::Main.start(ARGV)
    end
  end
end
