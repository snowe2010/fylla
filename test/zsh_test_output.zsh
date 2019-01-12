#compdef _executable executable
function _test_sub_noopts {
  _arguments \
    "-h[Show help information]" \
    "--help[Show help information]" \
    "1: :_commands" \
    "*::arg:->args"/.
}
function _test_sub_help {
  _arguments \
    "-h[Show help information]" \
    "--help[Show help information]" \
    "1: :_commands" \
    "*::arg:->args"/.
}
function _test_sub {
  local line

    function _commands {
    local -a commands
    commands=(
      'noopts:subcommand that takes no options'
      'help:Describe subcommands or one specific subcommand'
    )
    _describe 'command' commands
    }

  _arguments \
    "-h[Show help information]" \
    "--help[Show help information]" \
    "1: :_commands" \
    "*::arg:->args"/.
  case $line[1] in
    noopts)
    _test_sub_noopts
    ;;
    help)
    _test_sub_help
    ;;
  esac
}
function _test_generate_completions {
  _arguments \
    "-h[Show help information]" \
    "--help[Show help information]" \
    "1: :_commands" \
    "*::arg:->args"/.
}
function _test {
  local line

    function _commands {
    local -a commands
    commands=(
      'sub:a subcommand'
      'generate_completions:generate completions'
    )
    _describe 'command' commands
    }

  _arguments \
    "-h[Show help information]" \
    "--help[Show help information]" \
    "1: :_commands" \
    "*::arg:->args"/.
  case $line[1] in
    sub)
    _test_sub
    ;;
    generate_completions)
    _test_generate_completions
    ;;
  esac
}
