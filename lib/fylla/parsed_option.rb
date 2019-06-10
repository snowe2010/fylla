module Fylla
  class ParsedOption
    attr_accessor :aliases, :description, :name, :enum, :filter
    attr_reader :completion, :banner # used just for parsing class_options recursively. Don't ever set these.

    def initialize(name, description, aliases, enum, filter)
      @name = name
      @description = description
      @aliases = aliases
      @enum = enum || nil
      @filter = filter
    end
  end
end
