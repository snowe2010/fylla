require 'thor'

class Subcommand < Thor
  include Thor::Base
  desc "noopts", "subcommand that takes no options"

  def noopts
    puts "noopts"
  end
end

class CLI < Thor
  include Thor::Base
  desc "sub", "a subcommand"
  subcommand "sub", Subcommand

  desc "generate_completions", "generate completions"

  def generate_completions
    puts self.class.zsh_completion
  end
end

Thor.prepend ThorExtensions::Thor::CompletionGenerator
