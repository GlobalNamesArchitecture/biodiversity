require 'rubygems'
require 'spec'
require 'treetop'
require 'yaml'

#NOTE: this spec needs compiled treetop files.
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../lib/biodiversity/parser')

describe ScientificNameClean do
  before(:all) do
    @parser = ScientificNameParser.new 
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
  
  def json(input)
    parse(input).to_json
  end
  
  it 'should parse accurate name' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:species=>"dendrobii", :genus=>"Pseudocercospora"}
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
    canonical('Quoyula').should == 'Quoyula'
    parse('Perissandra laotica').should_not be_nil
  end
  
  it 'should parse inaccurate name' do
    parse("Tridentella tangeroae Bruce, 198?").should_not be_nil
  end
  
  it 'should parse name that cannot be fully parsed' do
    parse("Plantago major ESEFDSlj sdafsladjfasd fd ;asldfjasfas#&^&*^*^&}}").should_not be_nil
    canonical('Plantago major ESEFDSlj sdafsladjfasd fd ;asldfjasfas#&^&*^*^&}}').should == 'Plantago major'
  end
  
  it 'should generate pos_json output' do
    parse("Plantago major").pos_json.should == '{"0":["genus",8],"9":["species",14]}'
  end
  
  it 'should generate standardized json' do
    f = open(File.expand_path(dir + "../../spec/parser/test_data.txt"))
    f.each do |line|
      name, jsn, notes = line.split("|")
      next unless name && jsn
      JSON.load(json(name)).should == JSON.load(jsn)
    end
  end
end