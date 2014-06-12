# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'power_resource/version'

Gem::Specification.new do |spec|
  spec.name          = 'power_resource'
  spec.version       = PowerResource::VERSION
  spec.authors       = ['Jari Jokinen']
  spec.email         = ['info@jarijokinen.com']
  spec.description   = 'Power up RESTful resources!'
  spec.summary       = 'Power up RESTful resources!'
  spec.homepage      = 'https://github.com/jarijokinen/power_resource'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.1.2'

  spec.add_dependency 'rails', '~> 4.1.1'
  spec.add_dependency 'activerecord', '~> 4.1.1'
  spec.add_dependency 'inherited_resources', '~> 1.5.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'capybara', '~> 2.3.0'
  spec.add_development_dependency 'database_cleaner', '~> 1.3.0'
  spec.add_development_dependency 'rake', '~> 10.1.0'
  spec.add_development_dependency 'rspec-rails', '~> 2.14.0'
  spec.add_development_dependency 'sqlite3', '~> 1.3.9'
end
