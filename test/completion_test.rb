require_relative 'test_helper'
require_relative 'cli'

class CompletionTest < Minitest::Test
  def test_cli_start_completion_generator
    ARGV.clear
    ARGV << 'generate_completions'
    expected = File.read(File.join(__dir__, 'zsh_test_output.zsh'))
    assert_output(expected) {CLI.start(ARGV)}
  end

end
