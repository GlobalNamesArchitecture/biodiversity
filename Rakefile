dir = File.dirname(__FILE__)
require 'rubygems'
require 'rake'
$LOAD_PATH.unshift(File.join(dir, 'vendor', 'rspec', 'lib'))
require 'spec/rake/spectask'

#Gem::manage_gems
require 'rake/gempackagetask'

task :default => :spec

#begin
#  require 'jeweler'
#  Jeweler::Tasks.new do |gemspec|
#    gemspec.name = "biodiversity"
#    gemspec.summary = "scientific species name parser\n\nExecutable is nnparse"
#    gemspec.email = "dmozzherin {et} eol {dt} org"
#    gemspec.homepage = "http://github.com/dimus/biodiversity"
#    gemspec.description = "Biodiversity library provides a parser tool for scientific species names"
#    gemspec.authors = ["Dmitry Mozzherin", "Anna Shipunova"]
#  end
#rescue LoadError
#  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
#end



task :tt do
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_clean.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_dirty.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_canonical.treetop")
end

task :files do
  puts FileList["LICENSE", "README.rdoc", "Rakefile", "{spec,lib,bin,doc,examples}/**/*"].to_a.join(' ')
end

Spec::Rake::SpecTask.new do |t|
  t.pattern = 'spec/**/*spec.rb'
end

