require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "biodiversity"
    gem.summary = 'Parser of scientific names'
    gem.description = 'Tools for biodiversity informatics'
    gem.email = "dmozzherin@gmail.com"
    gem.homepage = "http://github.com/dimus/biodiversity"
    gem.authors = ["Dmitry Mozzherin"]
    gem.has_rdoc = false
    gem.bindir = 'bin'
    gem.executables = ['nnparse']
    gem.add_dependency('treetop')
    gem.add_dependency('json') if RUBY_VERSION.split(".")[0..1].join('').to_i < 19
    gem.add_development_dependency "rspec"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.spec_files = FileList['spec/**/*_spec.rb']
end


task :default => :spec

#require 'rake/rdoctask'
#Rake::RDocTask.new do |rdoc|
#  if File.exist?('VERSION')
#    version = File.read('VERSION')
#  else
#    version = ""
#  end
#
#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title = "biodiversity #{version}"
#  rdoc.rdoc_files.include('README*')
#  #rdoc.rdoc_files.include('lib/**/*.rb')
#end

task :tt do
  dir = File.dirname(__FILE__)
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_clean.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_dirty.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_canonical.treetop")
end

