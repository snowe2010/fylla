require_relative '../test_helper'
require_relative 'test_commands/plain_subcommand'


class CompletionTest < Minitest::Test
  def setup
    Fylla.load('test')
  end

  def test_cli_start_completion_generator
    expected = <<~'HERE'
      #compdef _test test
      function _test_help {
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
      function _test_generate_completions {
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
      function _test_sub_noopts {
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
      function _test_sub_withopts {
        _arguments \
          "--an_option[AN_OPTION]" \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
      function _test_sub_help {
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]"
      }
      function _test_sub {
        local line
      
        local -a commands
        commands=(
          'help:Describe subcommands or one specific subcommand'
          'noopts:subcommand that takes no options'
          'withopts:subcommand that takes options'
        )
      
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: : _describe 'command' commands" \
          "*::arg:->args"

        case $state in
          args)
            case $line[1] in
              help)
                _test_sub_help
              ;;
              noopts)
                _test_sub_noopts
              ;;
              withopts)
                _test_sub_withopts
              ;;
            esac
          ;;
        esac
      }
      function _test {
        local line
      
        local -a commands
        commands=(
          'generate_completions:generate completions'
          'help:Describe available commands or one specific command'
          'sub:a subcommand'
        )
      
        _arguments \
          "-h[Show help information]" \
          "--help[Show help information]" \
          "1: : _describe 'command' commands" \
          "*::arg:->args"

        case $state in
          args)
            case $line[1] in
              generate_completions)
                _test_generate_completions
              ;;
              help)
                _test_help
              ;;
              sub)
                _test_sub
              ;;
            esac
          ;;
        esac
      }
      _test "$@"
    HERE

    ARGV.clear
    ARGV << 'generate_completions'
    assert_output(expected) do
      Zsh::PlainSubcommands::Main.start(ARGV)
    end
  end
end
