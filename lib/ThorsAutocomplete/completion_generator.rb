module ThorExtensions
  module Thor
    module CompletionGenerator
      def self.prepended(base)
        base.singleton_class.prepend(ClassMethods)
      end

      def ClassMethods
        def completion
        end
      end
    end
  end
end