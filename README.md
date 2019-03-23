[![Build Status](https://travis-ci.com/snowe2010/fylla.svg?branch=master)](https://travis-ci.com/snowe2010/fylla)
[![codecov](https://codecov.io/gh/snowe2010/fylla/branch/master/graph/badge.svg)](https://codecov.io/gh/snowe2010/fylla)
[![Ruby gem](https://img.shields.io/gem/v/fylla.svg)](https://rubygems.org/gems/fylla)

# Fylla

Fylla, the Norse word for `complete`, is an autocompletion script generator for the [Thor](whatisthor.com) framework.

Fylla currently generates zsh completion scripts. Support for bash scripts will be added.

## Installation

Add the following line to your application's Gemfile:

```ruby
gem 'fylla'
```

execute using the following command:

    $ bundle

Or install fylla manually:

    $ gem install fylla

## Usage

`Fylla` must be loaded before `Thor.start` can be used. 

General use case will be to create a new subcommand or option that calls `Fylla.zsh_completion(self)`

`Fylla#zsh_completion` returns a string containing the entire zsh completion script and bash completion script. Scripts are ready for use after `Fylla#zsh_completion` returns.

`Thor` is required to load commands/options/etc before calling `Fylla.zsh_completion(self)`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. Run `bin/console` for an interactive prompt that allows experimentation.

To install the gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcomed on GitHub at https://github.com/snowe2010/fylla. Fylla is intended to be a safe, welcoming space for collaboration. Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

People interacting in the Fylla project’s codebases, issue trackers, chat rooms and mailing lists are expected to follow the [code of conduct](https://github.com/[USERNAME]/fylla/blob/master/CODE_OF_CONDUCT.md).

## Todo list

* Use description if banner isn't present,
* add completion parameter to Option class to use by default,
* allow zsh_completion and bash_completion to be called from _anywhere_, and 
* allow supplying custom templates.
