dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'
require 'yaml'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_dirty'))

describe ScientificNameDirty do
  before(:all) do
    @parser = ScientificNameDirtyParser.new 
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
  
  it 'should parse clean names' do
    parse("Betula verucose (L.) Bar. 1899").should_not be_nil
  end
  
  # it 'should parse names with unparsed parts at the end' do
  #   #parse("Ctenomys pearsoni Lessa and Langguth, 1983 (action needed)").should_not be_nil
  #   #value("Ctenomys pearsoni Lessa and Langguth, 1983 (action needed)").should = ''
  # end
  # 
  # it 'should parse and instead of &' do
  #   parse("Tridentella tangeroae Bruce and Crom, 1988").should_not be_nil
  #   value("Tridentella tangeroae Bruce and Crom, 1988B").should == "Tridentella tangeroae Bruce & Crom 1988B"
  # end
  # 
  # it 'should parse dirty years' do
  #   parse("Tridentella tangeroae Bruce, 1988B").should_not be_nil
  #   parse("Tridentella tangeroae Bruce, 1988b").should_not be_nil
  #   parse("Tridentella tangeroae Bruce, 1988d").should_not be_nil
  #   parse("Tridentella tangeroae Bruce, 198?").should_not be_nil
  #   parse("Tridentella tangeroae Bruce, 1987-92").should_not be_nil
  # end

end