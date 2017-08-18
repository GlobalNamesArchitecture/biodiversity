$:.push File.expand_path("../lib", __FILE__)

require "biodiversity/version"

Gem::Specification.new do |gem|
  gem.name          = "biodiversity"
  gem.version       = Biodiversity::VERSION
  gem.homepage      = "https://github.com/GlobalNamesArchitecture/biodiversity"
  gem.license       = "MIT"
  gem.summary       = "Parser of scientific names"
  gem.description   = "Tools for biodiversity informatics"
  gem.authors       = ["Dmitry Mozzherin"]
  gem.email         = "dmozzherin@gmail.com"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = ["nnparse", "parserver"]
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "treetop", "~> 1.6.8"
  gem.add_runtime_dependency "parallel", "~> 1.4"
  gem.add_runtime_dependency "unicode_utils", "~> 1.4"
  gem.add_runtime_dependency "gn_uuid", "~> 0.5"

  gem.add_development_dependency "bundler", "~> 1.6"
  gem.add_development_dependency "rake", "~> 10.4"
  gem.add_development_dependency "rspec", "~> 3.2"
  gem.add_development_dependency "webmock", "~> 2.3.1"
  gem.add_development_dependency "rr", "~> 1.1"
  gem.add_development_dependency "rubocop", "~> 0.29"
end
