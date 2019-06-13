require 'thor'

# add more options to Thor::Option
#
# :completion => allows providing a custom completion description for zsh
# :filter => allows filtering completions for arrays based on past completions
module Fylla
  module Thor
    module Option
      attr_accessor :completion, :filter
      def initialize(name, options = {})
        @completion = options[:fylla]&.[](:completion)
        @filter = options[:fylla]&.[](:filter)
        @filter = true if @filter.nil?
        super
      end
    end
  end
end
