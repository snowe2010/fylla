module Fylla
  class ParsedOption
    attr_accessor :aliases, :description, :name
    # used just for parsing class_options recursively. Don't ever set these.
    # used for erb file action
    attr_reader :completion, :banner, :enum, :filter, :type, :action, :equals_type

    def initialize(name, description, aliases, enum, filter, type)
      @name = name
      @description = description
      @aliases = aliases
      # used for switches that take values (everything, but not necessary for boolean)
      @equals_type = type == :boolean ? "" : "="
      @action = ""
      return unless enum

      case type
      when :array
        @action = if filter
                    %(: :_values -s , 'options' #{enum.join(" ")})
                  else
                    %(: :_sequence -d compadd - #{enum.join(" ")})
                  end
      when :string
        @action = %|: :(#{enum.join(" ")})|
      end
    end
  end
end
