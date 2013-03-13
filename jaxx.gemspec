# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jaxx/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Marc Watts"]
  gem.email         = ["marcky.sharky@googlemail.com"]
  gem.description   = %q{Command line wrapper for pushing files to S3}
  gem.summary       = %q{RubyGems to allow any file to be pushed to S3 in the simplist way}
  gem.homepage      = "https://github.com/marckysharky/jaxx"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jaxx"
  gem.require_paths = ["lib"]
  gem.version       = Jaxx::VERSION

  gem.add_dependency 'excon', '0.20.0'
  gem.add_dependency 'fog',   '1.10.0'
  gem.add_dependency 'json'
  gem.add_dependency 'mime-types'

  gem.add_development_dependency  'rake'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'aruba'
  gem.add_development_dependency 'guard-cucumber'
end
