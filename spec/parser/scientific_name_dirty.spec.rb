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
  
  it 'should parse year with []' do
    parse("Anthoscopus Cabanis [1851]").should_not be_nil
    value("Anthoscopus Cabanis [185?]").should == "Anthoscopus Cabanis (185?)"
    parse("Anthoscopus Cabanis [1851?]").should_not be_nil
    value("Anthoscopus Cabanis [1851]").should == "Anthoscopus Cabanis (1851)"
    value("Anthoscopus Cabanis [1851?]").should == "Anthoscopus Cabanis (1851?)"
    details("Anthoscopus Cabanis [1851?]").should == {:uninomial=>"Anthoscopus", :authors=>{:names=>["Cabanis"], :approximate_year=>"(1851?)"}}
    
    parse("Trismegistia monodii Ando, 1973 [1974]").should_not be_nil
    details("Trismegistia monodii Ando, 1973 [1974]").should == {:genus=>"Trismegistia", :species=>"monodii", :authors=>{:ambiguous_year=>"1973 [1974]", :names=>["Ando"]}}
    parse("Zygaena witti Wiegel [1973]").should_not be_nil
    parse("Deyeuxia coarctata Kunth, 1815 [1816]").should_not be_nil
  end

  it 'should parse year page number' do
    val = "Gymnodactylus irregularis WERMUTH 1965: 54"
    parse(val).should_not be_nil
    value(val).should == "Gymnodactylus irregularis WERMUTH 1965"
    details(val).should == {:genus=>"Gymnodactylus", :species=>"irregularis", :authors=>{:names=>["WERMUTH"], :year=>"1965"}}    
  end
  
  # Moraea spathulata ( (L. f.) ) Klatt
  # Eichornia crassipes ( (Martius) ) Solms-Laub.
  # Vitex agnus-castus fo. alba ( (West.) ) Rehder
  # Pelargonium cucullatum ( (L.) ) L'Her.
  # Meiostemon humbertii ( (H. Perrier) ) Exell & Stace
 # it 'should parse double parenthesis' do
 #   val = "Eichornia crassipes ((Martius) Solms-Laub."
#    parse(val).should_not be_nil
    # value(val).should == "Gymnodactylus irregularis WERMUTH 1965"
    # details(val).should == {:genus=>"Gymnodactylus", :species=>"irregularis", :authors=>{:names=>["WERMUTH"], :year=>"1965"}}    
  end
  
  
  
  # Acomys "Geoffroy, I." 1838
  # Verpericola megasoma "Dall" Pils.
  # Auricotes neoclayae "Price, Hellenthal and Palma 2003"
  # Leccinum cinnamomeum var. cinnamomeum "A.H. Sm.
  
  # it 'should parse quote' do
  #   val = 'Acomys "Geoffroy, I." 1838'
  # end
  

  it 'should parse canonical with garbage' do
    sn = '' 
    # Euschides (LeConte JL 1858
    parse(sn).should_not be_nil
    # value(sn).should == 'Euschides'
    # canonical(sn).should == 'Euschides'
    # details(sn).should == {:uninomial=>"Euschides"} 
  end


#  it 'should parse author with []' do
 #     puts parse("Farsetia mutabilis [R.Br.]")#.should_not be_nil
 #   value("Anthoscopus Cabanis [185?]").should == "Anthoscopus Cabanis (185?)"
 #   details("Anthoscopus Cabanis [1851?]").should == {:uninomial=>"Anthoscopus", :authors=>{:names=>["Cabanis"], :approximate_year=>"(1851?)"}}
  #end
  
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