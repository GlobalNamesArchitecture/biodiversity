# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'biodiversity/version'

Gem::Specification.new do |gem|
  gem.required_ruby_version = '>= 2.6'
  gem.name          = 'biodiversity'
  gem.version       = Biodiversity::VERSION
  gem.homepage      = 'https://github.com/GlobalNamesArchitecture/biodiversity'
  gem.license       = 'MIT'
  gem.summary       = 'Parser of scientific names'
  gem.description   = 'Parsing tool for biodiversity informatics'
  gem.authors       = ['Dmitry Mozzherin']
  gem.email         = 'dmozzherin@gmail.com'

  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'csv', '~> 3.3'
  gem.add_runtime_dependency 'ffi', '~> 1.17'

  gem.add_development_dependency 'byebug', '~> 13.0'
  gem.add_development_dependency 'rake', '~> 13.4'
  gem.add_development_dependency 'rspec', '~> 3.13'
  gem.add_development_dependency 'rubocop', '~> 1.91'
  gem.add_development_dependency 'rubocop-rubycw', '~> 0.2.2'
  gem.add_development_dependency 'solargraph', '~> 0.60'
end
