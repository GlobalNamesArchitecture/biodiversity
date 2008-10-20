dir = File.dirname(__FILE__)
require 'rubygems'
require 'rake'
$LOAD_PATH.unshift(File.join(dir, 'vendor', 'rspec', 'lib'))
require 'spec/rake/spectask'

Gem::manage_gems
require 'rake/gempackagetask'

task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.pattern = 'spec/**/*spec.rb'
end

gemspec = Gem::Specification.new do |s|
  s.name = "biodiversity"
  s.version = "0.1.0"
  s.author = "Dmitry Mozzherin"
  s.email = "dmozzherin {et} eol {.} org"
  s.homepage = "http://functionalform.blogspot.com"
  s.platform = Gem::Platform::RUBY
  s.summary = "A Ruby-based set of biodiversity tools"
  s.files = FileList["README", "Rakefile", "{spec,lib,bin,doc,examples}/**/*"].to_a
  s.bindir = "bin"
  s.executables = ["nnparse"]
  s.require_path = "lib"
  s.autorequire = "biodiversity"
  s.has_rdoc = false
  s.add_dependency "treetop"
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_tar = true
end
