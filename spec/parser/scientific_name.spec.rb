#NOTE: this spec needs compiled treetop files.
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')
require File.expand_path(dir + '../../lib/biodiversity/parser')

describe ScientificNameClean do
  before(:all) do
    set_parser(ScientificNameParser.new)
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