class ParsedCommand
  attr_accessor :ancestor_name, :description, :name, :options

  def initalize(ancestor_name, description, name, options)
    @ancestor_name = ancestor_name
    @description = description
    @name = name
    @options = class_options
  end
end
