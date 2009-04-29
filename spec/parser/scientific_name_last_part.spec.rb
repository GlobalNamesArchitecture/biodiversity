dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'
require 'yaml'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_dirty'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_last_part'))


describe ScientificNameLastPart do
  before(:all) do
    @parser = ScientificNameLastPartParser.new 
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
    
  it 'should parse names with valid name part and unparseable rest' do
    [
      ['Moraea spathulata ( (L. f. Klatt','Moraea spathulata',{:genus=>"Moraea", :species=>"spathulata"} ],
      ['Verpericola megasoma ""Dall" Pils.','Verpericola megasoma',{:genus=>"Verpericola", :species=>"megasoma"}],
     ['Euschides (LeConte JL 1858','Euschides', {:uninomial=>"Euschides"}] 
    ].each do |n|
      parse(n[0]).should_not be_nil
      value(n[0]).should == n[1]
      details(n[0]).should == n[2]
    end
  end  
end