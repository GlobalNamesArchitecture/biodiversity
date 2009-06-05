dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'
require 'yaml'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_clean'))
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
  
  def pos(input)
    parse(input).pos
  end
  
  it 'should parse clean names' do
    parse("Betula verucose (L.) Bar. 1899").should_not be_nil
  end
  
  it 'should parse year with []' do
    parse("Anthoscopus Cabanis [1851]").should_not be_nil
    value("Anthoscopus Cabanis [185?]").should == "Anthoscopus Cabanis (185?)"
    parse("Anthoscopus Cabanis [1851?]").should_not be_nil
    value("Anthoscopus Cabanis [1851]").should == "Anthoscopus Cabanis (1851)"
    sn = "Anthoscopus Cabanis [1851?]"
    value(sn).should == "Anthoscopus Cabanis (1851?)"
    details(sn).should == {:uninomial=>"Anthoscopus", :authors=>{:names=>["Cabanis"], :approximate_year=>"(1851?)"}, :name_part_verbatim=>"Anthoscopus", :auth_part_verbatim=>"Cabanis [1851?]"}
    pos(sn).should == {0=>["uninomial", 11], 12=>["author_word", 19], 21=>["year", 26]}
    sn = "Trismegistia monodii Ando, 1973 [1974]"
    parse(sn).should_not be_nil
    value(sn).should == 'Trismegistia monodii Ando 1973 [1974]' #should it be 'Trismegistia monodii Ando 1973 (1974)' instead?
    details(sn).should == {:genus=>"Trismegistia", :species=>"monodii", :authors=>{:names=>["Ando"], :ambiguous_year=>"1973 [1974]"}, :name_part_verbatim=>"Trismegistia monodii", :auth_part_verbatim=>"Ando, 1973 [1974]"}
    pos(sn).should ==  {0=>["genus", 12], 13=>["species", 20], 21=>["author_word", 25], 27=>["year", 31], 33=>["year", 37]} 
    parse("Zygaena witti Wiegel [1973]").should_not be_nil
    sn = "Deyeuxia coarctata Kunth, 1815 [1816]"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 8], 9=>["species", 18], 19=>["author_word", 24], 26=>["year", 30], 32=>["year", 36]}
  end

  it 'should parse year with page number' do
    sn = "Gymnodactylus irregularis WERMUTH 1965: 54"
    parse(sn).should_not be_nil
    value(sn).should == "Gymnodactylus irregularis WERMUTH 1965"
    details(sn).should == {:genus=>"Gymnodactylus", :species=>"irregularis", :authors=>{:names=>["WERMUTH"], :year=>"1965"}, :name_part_verbatim=>"Gymnodactylus irregularis", :auth_part_verbatim=>"WERMUTH 1965: 54"}   
    pos(sn).should ==  {0=>["genus", 13], 14=>["species", 25], 26=>["author_word", 33], 34=>["year", 38]} 
  end
  
  it 'should parse double parenthesis' do
    sn = "Meiostemon humbertii ( (H. Perrier) ) Exell & Stace"
    parse(sn).should_not be_nil
    value(sn).should == "Meiostemon humbertii (H. Perrier) Exell et Stace"
    details(sn).should == {:genus=>"Meiostemon", :species=>"humbertii", :orig_authors=>{:names=>["H. Perrier"]}, :authors=>{:names=>["Exell", "Stace"]}, :name_part_verbatim=>"Meiostemon humbertii", :auth_part_verbatim=>"( (H. Perrier) ) Exell & Stace"}
    pos(sn).should == {0=>["genus", 10], 11=>["species", 20], 24=>["author_word", 26], 27=>["author_word", 34], 38=>["author_word", 43], 46=>["author_word", 51]}
  end  
  
  # Acomys "Geoffroy, I." 1838
  # Verpericola megasoma "Dall" Pils.
  # Auricotes neoclayae "Price, Hellenthal and Palma 2003"
  # Leccinum cinnamomeum var. cinnamomeum "A.H. Sm.
  
  # it 'should parse quote' do
  #   val = 'Acomys "Geoffroy, I." 1838'
  # end

  # it 'should parse author with []' do
  #  # OK parse("Farsetia mutabilis [ R.Br. ]").should_not be_nil
  #  parse("Farsetia mutabilis [R.Br.]").should_not be_nil
  #  # value("Farsetia mutabilis [R.Br.]").should == "Farsetia mutabilis [R.Br.]"
  #  # details("Farsetia mutabilis [R.Br.]").should == {}
  # end
  
  it 'should parse dirty years' do
    parse("Tridentella tangeroae Bruce, 1988B").should_not be_nil
    parse("Tridentella tangeroae Bruce, 1988b").should_not be_nil
    parse("Tridentella tangeroae Bruce, 1988d").should_not be_nil
    sn = "Tridentella tangeroae Bruce, 198?"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 11], 12=>["species", 21], 22=>["author_word", 27], 29=>["year", 33]}
  end

  it 'should parse double years' do
    sn = "Tridentella tangeroae Bruce, 1987-92"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 11], 12=>["species", 21], 22=>["author_word", 27], 29=>["year", 36]}
  end

end