require 'thor'

# add the 'completion:' option to Thor::Option, which
# allows passing a shorter description for the shell
module Fylla
  module Thor
    module Option
      attr_accessor :completion
      def initialize(name, options = {})
        @completion = options[:completion]
        super
      end
    end
  end
end
