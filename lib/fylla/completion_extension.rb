require 'thor'

class Thor
  class Option
    attr_accessor :completion_text
    class << self
      def completion(completion_text)
        @completion_text = completion_text
      end
    end
  end
end