#NOTE: this spec needs compiled treetop files.
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')
require File.expand_path(dir + '../../lib/biodiversity/parser')

describe ScientificNameClean do
  before(:all) do
    set_parser(ScientificNameParser.new)
  end
  
  it 'should generate standardized json' do
    read_test_file do |y|
      JSON.load(json(y[:name])).should == JSON.load(y[:jsn]) unless y[:comment]
    end
  end
  
  # it 'should generate new test_file' do
  #   new_test = open(File.expand_path(dir + "../../spec/parser/test_data_new.txt"),'w')
  #   read_test_file do |y|
  #     if y[:comment]
  #       new_test.write y[:comment]
  #     else
  #       name = y[:name]
  #       jsn = json(y[:name])# rescue puts(y[:name])
  #       new_test.write("#{name}|#{jsn}\n")
  #     end
  #   end
  # end
  
  it 'should generate reasonable output if parser failed' do
    sn = 'ddd sljlkj 3223452432'
    json(sn).should == '{"scientificName":{"parsed":false,"verbatim":"ddd sljlkj 3223452432"}}'
  end

end