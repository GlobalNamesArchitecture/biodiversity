$:.push File.expand_path("..lib", __FILE__)

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
  s.require_paths = ['lib', 'lib/biodiversity', 'lib/biodiversity/parser',
    'lib/biodiversity/guid']
end
