$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift File.expand_path('../test', __dir__)

require 'fylla'
require 'fylla/completion_generator'
require 'minitest/autorun'
require 'minitest/hooks/default'

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
