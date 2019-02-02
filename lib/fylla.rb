require 'fylla/version'
require 'fylla/completion_generator'
require 'fylla/parsed_command'
require 'fylla/parsed_subcommand'
require 'fylla/completion_extension'
require 'thor'

#
# Top level module for the Fylla project.
# Contains one method for initializing Fylla
#
module Fylla
  #
  # this method initializes [Fylla]
  # Call this _before_ #Thor.start is called.
  # @param executable_name [String] name of your thor executable, must be provided
  # here or through #self.zsh_completion or #self.bash_completion
  def self.load(executable_name = nil)
    @executable_name = executable_name || nil
    ::Thor.prepend Fylla::Thor::CompletionGenerator
    # ::Thor::Option.prepend Fylla::Thor::Option
  end

  #
  # Method to generate bash completions for the current [Thor] application
  # @param binding [Binding] _must always be self_
  # @param executable_name [String] name of your thor executable,
  #   must either be provided through #self.load or here.
  # @return [String] containing the entire zsh completion script.
  def self.zsh_completion(binding, executable_name = @executable_name)
    binding.class.zsh_completion(executable_name)
  end

  #
  # Method to generate bash completions for the current [Thor] application
  # @param binding [Binding] _must always be self_
  # @param executable_name [String] name of your thor executable,
  #   must either be provided through #self.load or here.
  # @return [String] containing the entire bash completion script.
  def self.bash_completion(binding, executable_name = @executable_name)
    binding.class.bash_completion(executable_name)
  end
end
