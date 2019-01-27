require_relative 'test_helper'
require_relative 'cli'

class CompletionTest < Minitest::Test
  def setup
    Fylla.load('test')
  end

  def test_cli_start_completion_generator
    ARGV.clear
    ARGV << 'generate_completions'
    expected = File.read(File.join(__dir__, 'zsh_test_output.zsh'))
    assert_output(expected) do
      Zsh::CLI::Main.start(ARGV)
    end
  end
end
