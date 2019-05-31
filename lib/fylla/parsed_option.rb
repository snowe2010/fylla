module Fylla
  class ParsedOption
    attr_accessor :aliases, :description, :name
    attr_reader :completion, :banner # used just for parsing class_options recursively. Don't ever set these.

    def initialize(name, description, aliases)
      @name = name
      @description = description
      @aliases = aliases
    end
  end
end
