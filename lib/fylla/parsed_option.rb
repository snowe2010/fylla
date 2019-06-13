module Fylla
  class ParsedOption
    attr_accessor :aliases, :description, :name
    attr_reader :completion, :banner, :enum, :filter, :type # used just for parsing class_options recursively. Don't ever set these.
    attr_reader :action, :equals_type # used for erb file action

    def initialize(name, description, aliases, enum, filter, type)
      @name = name
      @description = description
      @aliases = aliases
      @equals_type = type == :boolean ? '' : '=' # used for switches that take values (everything, but not necessary for boolean)
      @action = ''
      if enum
        case type
        when :array
          if filter
            @action = %Q|: :_values -s , 'options' #{enum.join(' ')}|
          else
            @action = %Q|: :_sequence -d compadd - #{enum.join(' ')}|
          end
        when :string
          @action = %Q|: :(#{enum.join(' ')})|
        end
      end
    end
  end
end
