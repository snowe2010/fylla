require 'fylla/version'
require 'fylla/completion_generator'
require 'fylla/parsed_command'
require 'fylla/parsed_subcommand'
require 'thor'

#
# Top level module for the Fylla project.
# Contains one method for initializing Fylla
#
module Fylla
  def self.load(executable_name = nil)
    @executable_name = executable_name || nil
    ::Thor.prepend Fylla::Thor::CompletionGenerator
  end

  def self.zsh_completion(binding, executable_name = @executable_name)
    binding.class.zsh_completion(executable_name)
  end
end
