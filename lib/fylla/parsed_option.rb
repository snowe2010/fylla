module Fylla
  class ParsedOption
    attr_accessor :aliases, :description, :name

    def initialize(name, description, aliases)
      @name = name
      @description = description
      @aliases = aliases
    end
  end
end
