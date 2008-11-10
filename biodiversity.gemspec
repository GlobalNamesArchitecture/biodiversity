Gem::Specification.new do |s|
  s.name = 'biodiversity'
  s.version = '0.0.9'
  s.date = '2008-10-21'
  
  s.summary = "scientific species name parser\n\nExecutable is nnparse"
  s.description = "Biodiversity library provides a parser tool for scientific species names"
  
  s.authors = ['Dmitry Mozzherin']
  s.email = 'dmozzherin {et} eol {dt} org'
  s.homepage = 'http://github.com/dimus/biodiversity/wikis'
  
  s.has_rdoc = false
  
  s.add_dependency 'treetop', ['>= 1.2.4']
  s.add_dependency 'json', ['>= 1.1.3']

  s.bindir = "bin"
  s.executable = %w(nnparse)
  
  s.files = %w(LICENSE README.rdoc Rakefile conf conf/environment.rb spec/parser spec/parser/scientific_name.spec.rb spec/guid  spec/guid/lsid.spec.rb lib/biodiversity lib/biodiversity/parser lib/biodiversity/guid.rb lib/biodiversity/guid lib/biodiversity/guid/lsid.rb lib/biodiversity/parser/scientific_name.rb lib/biodiversity/parser/scientific_name.treetop lib/biodiversity/parser.rb lib/biodiversity.rb bin/nnparse)
end
