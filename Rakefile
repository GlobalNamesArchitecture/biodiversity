dir = File.dirname(__FILE__)
require 'rubygems'
require 'rake'
#$LOAD_PATH.unshift(File.join(dir, 'vendor', 'rspec', 'lib'))
require 'spec/rake/spectask'

#Gem::manage_gems
#require 'rake/gempackagetask'

task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.pattern = 'spec/**/*spec.rb'
end


begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "biodiversity"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
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

task :tt do
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_clean.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_dirty.treetop")
  system("tt #{dir}/lib/biodiversity/parser/scientific_name_canonical.treetop")
end

