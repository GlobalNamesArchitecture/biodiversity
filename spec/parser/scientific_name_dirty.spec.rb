# encoding: UTF-8
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')

describe ScientificNameDirty do
  before(:all) do
   set_parser(ScientificNameDirtyParser.new)
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
  
  def debug(input)
    res = parse(input)
    puts "<pre>"
      if res
        puts 'success!'
        puts res.inspect
      else
        puts input
        val = @parser.failure_reason.to_s.match(/column [0-9]*/).to_s.gsub(/column /,'').to_i
        print ("-" * (val - 1))
        print "^   Computer says 'no'!\n"
        puts @parser.failure_reason
        puts @parser.to_yaml
      end
    puts "</pre>"
  end
  
  it 'should parse clean names' do
    parse("Betula verucosa (L.) Bar. 1899").should_not be_nil
  end
  
  it 'should parse double parenthesis' do
    sn = "Eichornia crassipes ( (Martius) ) Solms-Laub."
    parse(sn).should_not be_nil
    value(sn).should == "Eichornia crassipes (Martius) Solms-Laub."
    details(sn).should == {:genus=>{:epitheton=>"Eichornia"}, :species=>{:epitheton=>"crassipes", :authorship=>"( (Martius) ) Solms-Laub.", :combinationAuthorTeam=>{:authorTeam=>"Solms-Laub.", :author=>["Solms-Laub."]}, :basionymAuthorTeam=>{:authorTeam=>"Martius", :author=>["Martius"]}}}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 23=>["author_word", 30], 34=>["author_word", 45]} 
  end
  
  it "should parse year without author" do
    sn = "Acarospora cratericola 1929"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 10], 11=>["species", 22], 23=>["year", 27]}
    details(sn).should == {:genus=>{:epitheton=>"Acarospora"}, :species=>{:epitheton=>"cratericola", :year=>"1929"}}
  end
  
  it 'should parse double years' do
    sn = "Tridentella tangeroae Bruce, 1987-92"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 11], 12=>["species", 21], 22=>["author_word", 27], 29=>["year", 36]}
    details(sn).should == {:genus=>{:epitheton=>"Tridentella"}, :species=>{:epitheton=>"tangeroae", :authorship=>"Bruce, 1987-92", :basionymAuthorTeam=>{:authorTeam=>"Bruce", :author=>["Bruce"], :year=>"1987-92"}}}
  end
  
  it 'should parse dirty years' do
    parse("Tridentella tangeroae Bruce, 1988B").should_not be_nil
    parse("Tridentella tangeroae Bruce, 1988b").should_not be_nil
    parse("Tridentella tangeroae Bruce, 1988d").should_not be_nil
    sn = "Tridentella tangeroae Bruce, 198?"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 11], 12=>["species", 21], 22=>["author_word", 27], 29=>["year", 33]}
  end
  
  it 'should parse year with page number' do
    sn = "Gymnodactylus irregularis WERMUTH 1965: 54"
    parse(sn).should_not be_nil
    value(sn).should == "Gymnodactylus irregularis WERMUTH 1965"
    details(sn).should == {:genus=>{:epitheton=>"Gymnodactylus"}, :species=>{:epitheton=>"irregularis", :authorship=>"WERMUTH 1965: 54", :basionymAuthorTeam=>{:authorTeam=>"WERMUTH", :author=>["WERMUTH"], :year=>"1965"}}}
    pos(sn).should ==  {0=>["genus", 13], 14=>["species", 25], 26=>["author_word", 33], 34=>["year", 38]} 
  end
  
  it 'should parse year with []' do
    parse("Anthoscopus Cabanis [1851]").should_not be_nil
    value("Anthoscopus Cabanis [185?]").should == "Anthoscopus Cabanis (185?)"
    parse("Anthoscopus Cabanis [1851?]").should_not be_nil
    value("Anthoscopus Cabanis [1851]").should == "Anthoscopus Cabanis (1851)"
    sn = "Anthoscopus Cabanis [1851?]"
    value(sn).should == "Anthoscopus Cabanis (1851?)"
    details(sn).should == {:uninomial=>{:epitheton=>"Anthoscopus", :authorship=>"Cabanis [1851?]", :basionymAuthorTeam=>{:authorTeam=>"Cabanis", :author=>["Cabanis"], :approximate_year=>"(1851?)"}}}
    pos(sn).should == {0=>["uninomial", 11], 12=>["author_word", 19], 21=>["year", 26]}
    sn = "Trismegistia monodii Ando, 1973 [1974]"
    parse(sn).should_not be_nil
    value(sn).should == 'Trismegistia monodii Ando 1973 (1974)' #should it be 'Trismegistia monodii Ando 1973 (1974)' instead?
    details(sn).should == {:genus=>{:epitheton=>"Trismegistia"}, :species=>{:epitheton=>"monodii", :authorship=>"Ando, 1973 [1974]", :basionymAuthorTeam=>{:authorTeam=>"Ando", :author=>["Ando"], :year=>"1973", :approximate_year=>"(1974)"}}}
    pos(sn).should ==  {0=>["genus", 12], 13=>["species", 20], 21=>["author_word", 25], 27=>["year", 31], 33=>["year", 37]} 
    parse("Zygaena witti Wiegel [1973]").should_not be_nil
    sn = "Deyeuxia coarctata Kunth, 1815 [1816]"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 8], 9=>["species", 18], 19=>["author_word", 24], 26=>["year", 30], 32=>["year", 36]}
  end
  
end