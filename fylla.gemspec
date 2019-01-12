lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fylla/version'

Gem::Specification.new do |spec|
  spec.name = 'fylla'
  spec.version = Fylla::VERSION
  spec.authors = ['Tyler Thrailkill']
  spec.email = ['tyler.b.thrailkill@gmail.com']

  spec.summary = 'Adds functions for generating autocomplete scripts for Thor applications'
  spec.description = '
  Fylla generates zsh and bash autocomplete scripts for Thor CLI applications.
  '
  spec.homepage = 'https://github.com/snowe2010/fylla'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/snowe2010/fylla'
    spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  # spec.add_development_dependency 'thor', '~> 0.20.3'
  spec.add_dependency 'thor', '~> 0.19.0'
end
