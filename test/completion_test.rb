require_relative "test_helper"
require_relative 'cli'

class CompletionTest < Minitest::Test
  def test_cli_start_completion_generator
    ARGV.clear
    ARGV << "generate_completions"
    CLI.start(ARGV)
  end

end
