dir = File.dirname(__FILE__)
require 'rubygems'
require 'rake'
$LOAD_PATH.unshift(File.join(dir, 'vendor', 'rspec', 'lib'))
require 'spec/rake/spectask'

Gem::manage_gems
require 'rake/gempackagetask'

task :default => :spec


task :tt do
  system("tt #{dir}/lib/biodiversity/parser/scientific_name.treetop")
end

task :files do
  puts FileList["LICENSE", "README.rdoc", "Rakefile", "{spec,lib,bin,doc,examples}/**/*"].to_a.join(' ')
end

Spec::Rake::SpecTask.new do |t|
  t.pattern = 'spec/**/*spec.rb'
end

