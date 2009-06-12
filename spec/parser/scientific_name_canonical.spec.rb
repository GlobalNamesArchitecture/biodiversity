dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'
require 'yaml'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_clean'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_dirty'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_canonical'))


describe ScientificNameCanonical do
  before(:all) do
    @parser = ScientificNameCanonicalParser.new 
  end
  
  def parse(input)
    @parser.parse(input)
  end
  
  def value(input)
    parse(input).value
  end
  
  def canonical(input)
    parse(input).canonical
  end
  
  def details(input)
    parse(input).details
  end
  
  def pos(input)
    parse(input).pos
  end
    
  it 'should parse names with valid name part and unparseable rest' do
    [
      ['Moraea spathulata ( (L. f. Klatt','Moraea spathulata','Moraea spathulata',{:genus=>"Moraea", :species=>"spathulata", :name_part_verbatim=>"Moraea spathulata", :auth_part_verbatim=>"( (L. f. Klatt"}, {0=>["genus", 6], 7=>["species", 17]} ],
      ['Verpericola megasoma ""Dall" Pils.','Verpericola megasoma','Verpericola megasoma',{:genus=>"Verpericola", :species=>"megasoma", :name_part_verbatim=>"Verpericola megasoma", :auth_part_verbatim=>"\"\"Dall\" Pils."}, {0=>["genus", 11], 12=>["species", 20]}],
      ['Nesticus cellulanus affinis Kulczynski, in Chyzer & Kulczynski, 1894','Nesticus cellulanus affinis','Nesticus cellulanus affinis',{:genus=>"Nesticus", :species=>"cellulanus", :subspecies=>{:rank=>"n/a", :value=>"affinis"}, :name_part_verbatim=>"Nesticus cellulanus", :auth_part_verbatim=>"Kulczynski, in Chyzer & Kulczynski, 1894"},{0=>["genus", 8], 9=>["species", 19], 20=>["subspecies", 27]}]
    ].each do |n|
      parse(n[0]).should_not be_nil
      value(n[0]).should == n[1]
      canonical(n[0]).should == n[2]
      details(n[0]).should == n[3]
      pos(n[0]).should == n[4]
    end
  end  
end