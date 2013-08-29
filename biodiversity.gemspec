$:.push File.expand_path("../lib", __FILE__)

require 'biodiversity/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'biodiversity'
  s.version = Biodiversity::VERSION
  s.homepage = 'https://github.com/GlobalNamesArchitecture/biodiversity'
  s.license = 'MIT'
  s.summary = %Q{Parser of scientific names}
  s.description = %Q{Tools for biodiversity informatics}
  s.authors = ['Dmitry Mozzherin']
  s.email = 'dmozzherin@gmail.com'
  s.files = `git ls-files`.split("\n")
  s.executables = ['nnparse', 'parserver']
  s.require_paths = ['lib']

  s.add_dependency 'treetop', '~> 1.4'
  s.add_dependency 'parallel', '~> 0.7'
  s.add_dependency 'unicode_utils', '~> 1.4'

  s.add_dependency 'bundler', '~> 1.3'                            
  s.add_dependency 'rake', '~> 10.1'   
  s.add_dependency 'debugger','~> 1.6'
  s.add_dependency 'rspec', '~> 2.14'
  s.add_dependency 'rr', '~> 1.1'
end
