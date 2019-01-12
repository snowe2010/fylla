class ParsedCommand
  attr_accessor :ancestor_name, :description, :name, :options

  def initialize(ancestor_name, description, name, options)
    @ancestor_name = ancestor_name
    @description = description
    @name = name
    @options = options
  end
end
