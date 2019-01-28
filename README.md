[![Build Status](https://travis-ci.com/snowe2010/fylla.svg?branch=master)](https://travis-ci.com/snowe2010/fylla)
[![codecov](https://codecov.io/gh/snowe2010/fylla/branch/master/graph/badge.svg)](https://codecov.io/gh/snowe2010/fylla)
[![Ruby gem](https://img.shields.io/gem/v/fylla.svg)](https://rubygems.org/gems/fylla)

# Fylla

Fylla, the Norse word for `complete`, is an autocompletion script generator for the [Thor](whatisthor.com) framework.

It currently generates zsh completion scripts, but will soon have support for bash scripts as well. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fylla'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fylla

## Usage

`Fylla` must be loaded before `Thor.start` is called in order for it to be used. 

General use case will be to create a new subcommand or option that calls `Fylla.zsh_completion(self)`

`Fylla#zsh_completion` returns a string containing the entire zsh completion script, that you can 
use to do what you see fit.

Same for bash completion.

The only requirement for calling `Fylla.zsh_completion(self)` is that `Thor` has loaded all commands/options/etc.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/snowe2010/fylla. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fylla project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fylla/blob/master/CODE_OF_CONDUCT.md).

## Todo list

* use desc if banner isn't present
* add completion parameter to Option class to use by default
* allow zsh_completion and bash_completion to be called from _anywhere_. This might be impossible. 
* allow supplying custom templates
