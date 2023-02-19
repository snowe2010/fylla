require "thor"

module Zsh
  class ThorTest < Thor
    include Thor::Base
    desc "generate_completions", "generate completions"

    def generate_completions
      puts Fylla.zsh_completion(self)
    end
  end
end
