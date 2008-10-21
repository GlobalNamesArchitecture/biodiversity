Gem::Specification.new do |s|
  s.name = 'biodiversity'
  s.version = '0.0.2'
  s.date = '2008-10-21'
  
  s.summary = "scientific species name parser"
  s.description = "Biodiversity library provides a parser tool for scientific species names"
  
  s.authors = ['Dmitry Mozzherin']
  s.email = 'dmozzherin {et} eol {dt} org'
  s.homepage = 'http://github.com/dimus/biodiversity/wikis'
  
  s.has_rdoc = false
  #s.rdoc_options = ['--main', 'README.rdoc']
  #s.rdoc_options << '--inline-source' << '--charset=UTF-8'
  #s.extra_rdoc_files = ['README.rdoc', 'LICENSE']
  
  s.add_dependency 'treetop', ['>= 1.2.4']
  
  s.files = %w(LICENSE README.rdoc Rakefile spec/parser spec/parser/scientific_name.spec.rb lib/biodiversity lib/biodiversity/parser lib/biodiversity/parser/scientific_name.rb lib/biodiversity/parser/scientific_name.treetop lib/biodiversity/parser.rb lib/biodiversity.rb bin/nnparse)
  s.bindir = "bin"
end