#NOTE: this spec needs compiled treetop files.
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')
require File.expand_path(dir + '../../lib/biodiversity/parser')

describe ScientificNameParser do
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
    json(sn).should == '{"scientificName":{"parsed":false,"parser_version":"test_version","verbatim":"ddd sljlkj 3223452432"}}'  end

  it "should show version when the flag :show_version set to true" do
    parse('Homo sapiens')[:scientificName][:parser_version].should_not be_nil
  end

  it "should show version for not spelled names" do
    parse('not_a_name')[:scientificName][:parser_version].should_not be_nil
  end

  it "should generate version for viruses" do
    parse('Nile virus')[:scientificName][:parser_version].should_not be_nil
  end
end


describe ParallelParser do
  it "should find number of cpus" do
    pparser = ParallelParser.new
    pparser.cpu_num.should > 0
  end

  it "should parse several names in parallel" do
    names = []
    read_test_file { |n| names << (n[:name]) if n[:name] }
    names.uniq!
    pparser = ParallelParser.new
    res = pparser.parse(names)
    names.size.should > 100
    res.keys.size.should == names.size
  end

end
