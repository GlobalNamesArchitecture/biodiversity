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
  
  it 'should parse accurate name' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:species=>"dendrobii", :genus=>"Pseudocercospora"}
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
  
    
end