require_relative 'test_helper'
require_relative 'bash_clis/cli'

SUBCOMMAND = <<~HERE
_foo()
{
  local cur prev

  cur=${COMP_WORDS[COMP_CWORD]}
  prev=${COMP_WORDS[COMP_CWORD-1]}

  case ${COMP_CWORD} in
    1)
      COMPREPLY=($(compgen -W "plain" -- ${cur}))
    ;;
    2)
      case ${prev} in
        configure)
          COMPREPLY=($(compgen -W "CM DSP NPU" -- ${cur}))
        ;;
        show)
          COMPREPLY=($(compgen -W "some other args" -- ${cur}))
        ;;
      esac
    ;;
    *)
      COMPREPLY=()
    ;;
  esac
}

complete -F _test test
  HERE

class BashTest < Minitest::Test
  def setup
    Fylla.load('test')
  end

  def test_bash_single_subcommand
    ARGV.clear
    ARGV << 'generate'
    expected = SUBCOMMAND
    # assert_output(expected) do
      CLI::Subcommand.start(ARGV)
    # end
  end

  def test_bash_single_subcommand_with_options
    ARGV.clear
    ARGV << 'generate'
    expected = SUBCOMMAND
    # assert_output(expected) do
      CLI::SubcommandWithOptions.start(ARGV)
    # end
  end

  def test_bash_nested_subcommand_with_options
    ARGV.clear
    ARGV << 'generate'
    expected = SUBCOMMAND
    # assert_output(expected) do
      CLI::SubcommandWithNestedSubcommandsAndOptions.start(ARGV)
    # end
  end
end
