module Fylla
  class ParsedSubcommand
    attr_accessor :name, :description, :commands, :class_options

    def initialize(name, description, commands, class_options)
      @name = name
      @description = description
      @commands = commands
      @class_options = class_options
    end
  end
end
