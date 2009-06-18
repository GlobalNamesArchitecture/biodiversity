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
  
  it 'should generate standardized json' do
    f = open(File.expand_path(dir + "../../spec/parser/test_data.txt"))
    f.each do |line|
      name, jsn, notes = line.split("|")
      next unless line.match(/^\s*#/) == nil && name && jsn 
      JSON.load(json(name)).should == JSON.load(jsn)
    end
  end

end