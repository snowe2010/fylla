[![Build Status](https://travis-ci.com/snowe2010/fylla.svg?branch=master)](https://travis-ci.com/snowe2010/fylla)
[![codecov](https://codecov.io/gh/snowe2010/fylla/branch/master/graph/badge.svg)](https://codecov.io/gh/snowe2010/fylla)
[![Ruby gem](https://img.shields.io/gem/v/fylla.svg)](https://rubygems.org/gems/fylla)

# Fylla

Fylla, the Norse word for `complete`, is an autocompletion script generator for the [Thor](whatisthor.com) framework.

## Installation

Add the following line to your application's Gemfile:

```ruby
gem 'fylla'
```

And execute using the following command:

    $ bundle

Or install fylla manually:

    $ gem install fylla

## Usage

Fylla must be loaded before `Thor.start` (the method) is called, in order for Fylla to be callable, else no completions will be generated.

General use case will be to create a new subcommand or option that calls `Fylla.zsh_completion(self)`

`Fylla#zsh_completion` returns a string containing the entire zsh completion script, that you can use to do what you see fit.

Same for bash completion.

The only requirement for calling `Fylla.zsh_completion(self)` is for `Thor` to load all commands/options/etc..

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install the gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcomed on GitHub at https://github.com/snowe2010/fylla. Fylla is intended to be a safe, welcoming space for collaboration. Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

People interacting in the Fylla project’s codebases, issue trackers, chat rooms and mailing lists are expected to follow the [code of conduct](https://github.com/[USERNAME]/fylla/blob/master/CODE_OF_CONDUCT.md).

## Todo list

* Use desc if banner isn't present
* add completion parameter to Option class to use by default
* allow zsh_completion and bash_completion to be called from anywhere. This might be impossible.
* allow supplying custom templates
