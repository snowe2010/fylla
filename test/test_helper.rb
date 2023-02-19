$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
$LOAD_PATH.unshift File.expand_path("../test", __dir__)

require "fylla"
require "fylla/completion_generator"
require "fylla/completion_extension"
require "minitest/autorun"
require "minitest/hooks/default"

def matches(expected)
  Regexp.new(Regexp.escape(expected))
end

require "simplecov"
SimpleCov.start

require "codecov"
SimpleCov.formatter = SimpleCov::Formatter::Codecov
