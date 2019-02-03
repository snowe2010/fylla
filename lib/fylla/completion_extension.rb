require 'thor'

class Thor
  class Option
    attr_accessor :completion
    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |name, options = {}|
      old_initialize.bind(self).call(name, options)
      @completion = options[:completion]
    end
    # def initialize(name, options = {})
    #   old_initialize
    # end

    class << self
      def completion(completion)
        @completion = completion
      end
    end
  end
end
