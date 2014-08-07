$:.push File.expand_path("../lib", __FILE__)

require 'biodiversity/version'

Gem::Specification.new do |gem|
  gem.name          = 'biodiversity'
  gem.version       = Biodiversity::VERSION
  gem.homepage      = 'https://github.com/GlobalNamesArchitecture/biodiversity'
  gem.license       = 'MIT'
  gem.summary       = %Q{Parser of scientific names}
  gem.description   = %Q{Tools for biodiversity informatics}
  gem.authors       = ['Dmitry Mozzherin']
  gem.email         = 'dmozzherin@gmail.com'

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = ['nnparse', 'parserver']
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'treetop', '~> 1.5'
  gem.add_runtime_dependency 'parallel', '~> 1.2'
  gem.add_runtime_dependency 'unicode_utils', '~> 1.4'

  gem.add_development_dependency 'bundler', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 10.3'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'webmock', '~> 1.13'
  gem.add_development_dependency 'rr', '~> 1.1'
  gem.add_development_dependency 'debugger', '~> 1.6'
end
