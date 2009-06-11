# encoding: UTF-8
dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'treetop'

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_clean'))

describe ScientificNameClean do
  before(:all) do
    @parser = ScientificNameCleanParser.new 
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
  
  it 'should parse uninomial' do
    sn = 'Pseudocercospora'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora'
    canonical(sn).should == 'Pseudocercospora'
    details(sn).should == {:uninomial=>"Pseudocercospora"}
    pos(sn).should == {0=>["uninomial", 16]}
  end
  
  it 'should parse uninomial with author and year' do
    sn = 'Pseudocercospora Dow 1913'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora Dow 1913'
    details(sn).should == {:authors=>{:year=>"1913", :names=>["Dow"]}, :name_part_verbatim=>"Pseudocercospora", :auth_part_verbatim=>"Dow 1913", :uninomial=>"Pseudocercospora"}
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 20], 21=>["year", 25]}
  end
  
  it 'should parse canonical' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:species=>"dendrobii", :genus=>"Pseudocercospora"}
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
  end
  
  it 'should parse subgenus ZOOLOGICAL' do
    sn = "Doriteuthis (Amerigo) pealeii Author 1999"
    parse(sn).should_not be_nil
    value(sn).should == "Doriteuthis (Amerigo) pealeii Author 1999"
    canonical(sn).should == "Doriteuthis pealeii"
    details(sn).should == {:genus=>"Doriteuthis", :subgenus=>"Amerigo", :species=>"pealeii", :authors=>{:names=>["Author"], :year=>"1999"}, :name_part_verbatim=>"Doriteuthis (Amerigo) pealeii", :auth_part_verbatim=>"Author 1999"}
    pos(sn).should == {0=>["genus", 11], 13=>["subgenus", 20], 22=>["subspecies", 29], 30=>["author_word", 36], 37=>["year", 41]}
  end
  
  it 'should parse æ in the name' do
    names = [
      ["Læptura laetifica Dow, 1913", "Laeptura laetifica Dow 1913"],
      ["Leptura lætifica Dow, 1913", "Leptura laetifica Dow 1913"],
      ["Leptura leætifica Dow, 1913", "Leptura leaetifica Dow 1913"],
      ["Leæptura laetifica Dow, 1913", "Leaeptura laetifica Dow 1913"],
      ["Leœptura laetifica Dow, 1913", "Leoeptura laetifica Dow 1913"],
      ['Ærenea cognata Lacordaire, 1872', 'Aerenea cognata Lacordaire 1872'],
      ['Œdicnemus capensis ehrenbergi', 'Oedicnemus capensis ehrenbergi'],
      ['Œnanthe œnanthe œnanthe','Oenanthe oenanthe oenanthe']
    ]
    names.each do |name_pair|
      parse(name_pair[0]).should_not be_nil
      value(name_pair[0]).should == name_pair[1]
    end
  end
  
  it 'should parse names with "common" utf-8 charactes' do
    names = ["Rühlella","Sténométope laevissimus Bibron 1855"].each do |name|
      parse(name).should_not be_nil
    end
  end
  
  it 'should parse names with a valid 2 letter genus' do
    ["Ca Dyar 1914",
    "Ea Distant 1911",
    "Ge Nicéville 1895",
    "Ia Thomas 1902",
    "Io Lea 1831",
    "Io Blanchard 1852",
    "Ix Bergroth 1916",
    "Lo Seale 1906",
    "Oa Girault 1929",
    "Ra Whitley 1931",
    "Ty Bory de St. Vincent 1827",
    "Ua Girault 1929",
    "Aa Baker 1940",
    #"Mc",
    "Ja Uéno 1955",
    "Zu Walters & Fitch 1960",
    "La Bleszynski 1966",
    "Qu Durkoop",
    "As Slipinski 1982",
    "Ba Solem 1983"].each do |name|
      parse(name).should_not be_nil
    end
    canonical('Quoyula').should == 'Quoyula'
  end

  it 'should parse year' do
    sn = "Platypus bicaudatulus Schedl 1935"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    sn = "Platypus bicaudatulus Schedl, 1935h"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    details(sn).should == {:genus=>"Platypus", :species=>"bicaudatulus", :authors=>{:names=>["Schedl"], :year=>"1935"}, :name_part_verbatim=>"Platypus bicaudatulus", :auth_part_verbatim=>"Schedl, 1935h"}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 22=>["author_word", 28], 30=>["year", 35]}
    parse("Platypus bicaudatulus Schedl, 1935B").should_not be_nil
  end
  
  it 'should parse species autonym for complex subspecies authorships' do
    parse("Aus bus Linn. var. bus").should_not be_nil
    details("Aus bus Linn. var. bus").should == {:genus=>"Aus", :species=>"bus", :subspecies=>[{:rank=>"var.", :value=>"bus"}], :species_authors=>{:authors=>{:names=>["Linn."]}}, :name_part_verbatim=>"Aus bus", :auth_part_verbatim=>"Linn. var. bus"}
    sn = "Agalinis purpurea (L.) Briton var. borealis (Berg.) Peterson 1987"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Agalinis", :species=>"purpurea", :subspecies=>[{:rank=>"var.", :value=>"borealis"}], :species_authors=>{:orig_authors=>{:names=>["L."]}, :authors=>{:names=>["Briton"]}}, :subspecies_authors=>{:orig_authors=>{:names=>["Berg."]}, :authors=>{:names=>["Peterson"], :year=>"1987"}}, :name_part_verbatim=>"Agalinis purpurea", :auth_part_verbatim=>"(L.) Briton var. borealis (Berg.) Peterson 1987"}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 17], 19=>["author_word", 21], 23=>["author_word", 29], 35=>["subspecies", 43], 45=>["author_word", 50], 52=>["author_word", 60], 61=>["year", 65]}
  end
  
  it 'should parse several authors' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should ==  {:genus=>"Pseudocercospora", :species=>"dendrobii", :authors=>{:names=>["U. Braun", "Crous"]}, :name_part_verbatim=>"Pseudocercospora dendrobii", :auth_part_verbatim=>"U. Braun & Crous"}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43]}
    sn = "Pseudocercospora dendrobii U. Braun and Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 40=>["author_word", 45]}
    sn = "Pseudocercospora dendrobii U. Braun et Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"    
  end

  it 'should parse several authors with a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>"Pseudocercospora", :species=>"dendrobii", :authors=>{:names=>["U. Braun", "Crous"], :year=>"2003"}, :name_part_verbatim=>"Pseudocercospora dendrobii", :auth_part_verbatim=>"U. Braun & Crous 2003"}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43], 44=>["year", 48]}
    sn = "Pseudocercospora dendrobii Crous, 2003"
    parse(sn).should_not be_nil
    parse("Zophosis persis (Chatanay, 1914)").should_not be_nil
    parse("Zophosis persis (Chatanay 1914)").should_not be_nil
    sn = "Zophosis persis (Chatanay), 1914"
    parse(sn).should_not be_nil
    value(sn).should == "Zophosis persis (Chatanay 1914)"
    details(sn).should == {:genus=>"Zophosis", :species=>"persis", :orig_authors=>{:names=>["Chatanay"]}, :year=>"1914", :name_part_verbatim=>"Zophosis persis", :auth_part_verbatim=>"(Chatanay), 1914"}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 15], 17=>["author_word", 25], 28=>["year", 32]}
    parse("Zophosis persis (Chatanay) 1914").should_not be_nil
    #parse("Zophosis persis Chatanay (1914)").should_not be_nil
  end  
  
  it 'should parse scientific name' do
    sn = "Abacetus laevicollis de Chaudoir, 1869"
    parse(sn).should_not be_nil
    #TODO!!!!!! canonical(sn).should == 'Abacetus laevicollis'
    parse("Pseudocercospora dendrobii (H.C. Burnett) U. Braun & Crous 2003").should_not be_nil
    value("Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003").should == "Pseudocercospora dendrobii (H.C. Burnett) U. Braun et Crous 2003"
    canonical("Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003").should == "Pseudocercospora dendrobii"

    sn = "Stagonospora polyspora M.T. Lucas & Sousa da Câmara 1934"
    parse(sn).should_not be_nil
    value(sn).should == "Stagonospora polyspora M.T. Lucas et Sousa da Câmara 1934"
    details(sn).should == {:genus=>"Stagonospora", :species=>"polyspora", :authors=>{:names=>["M.T. Lucas", "Sousa da Câmara"], :year=>"1934"}, :name_part_verbatim=>"Stagonospora polyspora", :auth_part_verbatim=>"M.T. Lucas & Sousa da Câmara 1934"}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 22], 23=>["author_word", 27], 28=>["author_word", 33], 36=>["author_word", 41], 42=>["author_word", 44], 45=>["author_word", 51], 52=>["year", 56]}
    parse("Cladoniicola staurospora Diederich, van den Boom & Aptroot 2001").should_not be_nil
    sn = "Yarrowia lipolytica var. lipolytica (Wick., Kurtzman & E.A. Herrm.) Van der Walt & Arx 1981"
    parse(sn).should_not be_nil
    value(sn).should == "Yarrowia lipolytica var. lipolytica (Wick., Kurtzman et E.A. Herrm.) Van der Walt et Arx 1981"
    pos(sn).should == {0=>["genus", 8], 9=>["species", 19], 25=>["subspecies", 35], 37=>["author_word", 42], 44=>["author_word", 52], 55=>["author_word", 59], 60=>["author_word", 66], 68=>["author_word", 71], 72=>["author_word", 75], 76=>["author_word", 80], 83=>["author_word", 86], 87=>["year", 91]}
    parse("Physalospora rubiginosa (Fr.) anon.").should_not be_nil
    parse("Pleurotus ëous (Berk.) Sacc. 1887").should_not be_nil
    parse("Lecanora wetmorei Śliwa 2004").should_not be_nil
    #   valid 
    #   infraspecific
    parse("Calicium furfuraceum * furfuraceum (L.) Pers. 1797").should_not be_nil
    parse("Exobasidium vaccinii ** andromedae (P. Karst.) P. Karst. 1882").should_not be_nil
    parse("Urceolaria scruposa **** clausa Flot. 1849").should_not be_nil
    parse("Cortinarius angulatus B gracilescens Fr. 1838").should_not be_nil
    parse("Cyathicula scelobelonium").should_not be_nil
    #   single quote that did not show
    #    parse("Phytophthora hedraiandra De Cock & Man in ?t Veld 2004"
    #   Phthora vastatrix d?Hérelle 1909
    #   author is exception
    sn = "Tuber liui A S. Xu 1999"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Tuber", :species=>"liui", :authors=>{:names=>["A S. Xu"], :year=>"1999"}, :name_part_verbatim=>"Tuber liui", :auth_part_verbatim=>"A S. Xu 1999"}
    pos(sn).should == {0=>["genus", 5], 6=>["species", 10], 11=>["author_word", 1], 13=>["author_word", 2], 16=>["author_word", 2], 19=>["year", 23]}
    parse('Xylaria potentillae A S. Xu').should_not be_nil
    parse("Agaricus squamula Berk. & M.A. Curtis 1860").should_not be_nil
    parse("Peltula coriacea Büdel, Henssen & Wessels 1986").should_not be_nil
    #had to add no dot rule for trinomials without a rank to make it to work
    sn = "Saccharomyces drosophilae anon."
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Saccharomyces", :species=>"drosophilae", :authors=>{:names=>["anon."]}, :name_part_verbatim=>"Saccharomyces drosophilae", :auth_part_verbatim=>"anon."}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 26=>["author_word", 31]}
  end
  
  it 'should parse several authors with several years' do
    sn = "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>"Pseudocercospora", :species=>"dendrobii", :orig_authors=>{:names=>["H.C. Burnett"], :year=>"1883"}, :authors=>{:names=>["U. Braun", "Crous"], :year=>"2003"}, :name_part_verbatim=>"Pseudocercospora dendrobii", :auth_part_verbatim=>"(H.C. Burnett 1883) U. Braun & Crous 2003"}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 28=>["author_word", 32], 33=>["author_word", 40], 41=>["year", 45], 47=>["author_word", 49], 50=>["author_word", 55], 58=>["author_word", 63], 64=>["year", 68]}
  end
  
  it 'should parse unknown original authors (auct.)/(hort.)/(?)' do
    parse("Tragacantha leporina (?) Kuntze").should_not be_nil
    value("Tragacantha    leporina (    ?      )       Kuntze").should == "Tragacantha leporina (?) Kuntze"
    sn = "Lachenalia tricolor var. nelsonii (auct.) Baker"
    parse(sn).should_not be_nil
    value(sn).should == "Lachenalia tricolor var. nelsonii (auct.) Baker"
    details(sn).should == {:genus=>"Lachenalia", :species=>"tricolor", :subspecies=>[{:rank=>"var.", :value=>"nelsonii"}], :orig_authors=>"unknown", :authors=>{:names=>["Baker"]}, :name_part_verbatim=>"Lachenalia tricolor var. nelsonii", :auth_part_verbatim=>"(auct.) Baker"}
    pos(sn).should == {0=>["genus", 10], 11=>["species", 19], 25=>["subspecies", 33], 35=>["unknown_author", 40], 42=>["author_word", 47]}
  end
  
  it 'should parse unknown authors auct./anon./hort./ht.' do
    sn = "Puya acris ht. ex Gentil"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 4], 5=>["species", 10], 11=>["unknown_author", 14], 18=>["author_word", 24]}
  end
  

  it 'should not parse serveral authors groups with several years NOT CORRECT' do
    parse("Pseudocercospora dendrobii (H.C. Burnett 1883) (Leight.) (Movss. 1967) U. Braun & Crous 2003").should be_nil
  end
  
  it 'should parse names with taxon concept sec. part' do
    sn = "Sténométope laevissimus sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Sténométope", :species=>"laevissimus", :taxon_concept=>{:authors=>{:names=>["Eschmeyer"], :year=>"2004"}}, :name_part_verbatim=>"Sténométope laevissimus", :auth_part_verbatim=>"sec. Eschmeyer 2004"}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 29=>["author_word", 38], 39=>["year", 43]}
    sn = "Sténométope laevissimus Bibron 1855 sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Sténométope", :species=>"laevissimus", :authors=>{:names=>["Bibron"], :year=>"1855"}, :taxon_concept=>{:authors=>{:names=>["Eschmeyer"], :year=>"2004"}}, :name_part_verbatim=>"Sténométope laevissimus", :auth_part_verbatim=>"Bibron 1855 sec. Eschmeyer 2004"}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 24=>["author_word", 30], 31=>["year", 35], 41=>["author_word", 50], 51=>["year", 55]}
    # 
    # puts "<pre>"
    # puts @parser.failure_reason
    # #puts @parser.public_methods.select{|r| r.match /fail/}
    # puts "</pre>"
  end

    
  it 'should parse utf-8 name' do
    sn = "Trematosphaeria phaeospora (E. Müll.)         L.             Holm 1957"
    parse(sn).should_not be_nil
    value(sn).should == "Trematosphaeria phaeospora (E. Müll.) L. Holm 1957"
    canonical(sn).should == "Trematosphaeria phaeospora"
    details(sn).should == {:genus=>"Trematosphaeria", :species=>"phaeospora", :orig_authors=>{:names=>["E. Müll."]}, :authors=>{:names=>["L. Holm"], :year=>"1957"}, :name_part_verbatim=>"Trematosphaeria phaeospora", :auth_part_verbatim=>"(E. Müll.) L. Holm 1957"}
    pos(sn).should == {0=>["genus", 15], 16=>["species", 26], 28=>["author_word", 30], 31=>["author_word", 36], 46=>["author_word", 48], 61=>["author_word", 65], 66=>["year", 70]}
  end
  
  it "should parse name with var." do
    sn = "Phaeographis inusta var. macularis(Leight.) A.L. Sm. 1861"
    parse(sn).should_not be_nil
    value(sn).should == "Phaeographis inusta var. macularis (Leight.) A.L. Sm. 1861"
    canonical(sn).should == "Phaeographis inusta macularis"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 19], 25=>["subspecies", 34], 35=>["author_word", 42], 44=>["author_word", 48], 49=>["author_word", 52], 53=>["year", 57]}
  end
  
it "should parse name with morph." do
  sn = "Callideriphus flavicollis morph. reductus Fuchs 1961"
  parse(sn).should_not be_nil
  value(sn).should == "Callideriphus flavicollis morph. reductus Fuchs 1961"
  canonical(sn).should == "Callideriphus flavicollis reductus"
  details(sn).should == {:genus=>"Callideriphus", :species=>"flavicollis", :subspecies=>[{:rank=>"morph.", :value=>"reductus"}], :authors=>{:names=>["Fuchs"], :year=>"1961"}, :name_part_verbatim=>"Callideriphus flavicollis morph. reductus", :auth_part_verbatim=>"Fuchs 1961"}
  pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 33=>["subspecies", 41], 42=>["author_word", 47], 48=>["year", 52]}
end

#  "subsect."/"subtrib."/"subgen."/"trib."/
#Stipa Speg. subgen. Leptostipa
#Sporobolus subgen. Sporobolus R.Br.

# it 'should parse name with "subsect."/"subtrib."/"subgen."/"trib."' do
#   val = "Sporobolus subgen. Sporobolus R.Br."
#   parse(val).should_not be_nil
#   # value(val).should == val
#   # canonical(val).should == "Callideriphus flavicollis reductus"
#   # details(val).should == {}
# end
  
  it "should parse name with forma/fo./form./f." do
    sn = "Caulerpa cupressoides forma nuda"
    parse(sn).should_not be_nil
    value(sn).should == "Caulerpa cupressoides f. nuda"
    canonical(sn).should == "Caulerpa cupressoides nuda"
    details(sn).should == {:genus=>"Caulerpa", :species=>"cupressoides", :subspecies=>[{:rank=>"f.", :value=>"nuda"}]}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 28=>["subspecies", 32]} 
    sn = "Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó"
    parse(sn).should_not be_nil
    value("Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó").should == "Chlorocyperus glaber f. fasciculariforme (Lojac.) Soó"
    canonical(sn).should == "Chlorocyperus glaber fasciculariforme"
    details(sn).should == {:genus=>"Chlorocyperus", :species=>"glaber", :subspecies=>[{:rank=>"f.", :value=>"fasciculariforme"}], :orig_authors=>{:names=>["Lojac."]}, :authors=>{:names=>["Soó"]}, :name_part_verbatim=>"Chlorocyperus glaber form. fasciculariforme", :auth_part_verbatim=>"(Lojac.) Soó"}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 20], 27=>["subspecies", 43], 45=>["author_word", 51], 53=>["author_word", 56]}
    sn = "Bambusa nana Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    parse(sn).should_not be_nil
    value(sn).should == "Bambusa nana Roxb. f. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    canonical(sn).should == "Bambusa nana alphonse-karri"
    details(sn).should == {:genus=>"Bambusa", :species=>"nana", :subspecies=>[{:rank=>"f.", :value=>"alphonse-karri"}], :species_authors=>{:authors=>{:names=>["Roxb."]}}, :subspecies_authors=>{:original_revised_name_authors=>{:revised_authors=>{:names=>["Mitford"]}, :authors=>{:names=>["Satow"]}}, :revised_name_authors=>{:revised_authors=>{:names=>["Makino"]}, :authors=>{:names=>["Shiros."]}}}, :name_part_verbatim=>"Bambusa nana", :auth_part_verbatim=>"Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."}
    pos(sn).should ==  {0=>["genus", 7], 8=>["species", 12], 13=>["author_word", 18], 23=>["subspecies", 37], 39=>["author_word", 46], 50=>["author_word", 55], 57=>["author_word", 63], 67=>["author_word", 74]}
    sn = "   Sphaerotheca    fuliginea     f.    dahliae    Movss.   1967    "
    parse(sn).should_not be_nil
    value(sn).should == "Sphaerotheca fuliginea f. dahliae Movss. 1967"
    canonical(sn).should == "Sphaerotheca fuliginea dahliae"
    details(sn).should ==  {:genus=>"Sphaerotheca", :species=>"fuliginea", :subspecies=>[{:rank=>"f.", :value=>"dahliae"}], :authors=>{:names=>["Movss."], :year=>"1967"}, :name_part_verbatim=>"Sphaerotheca    fuliginea     f.    dahliae", :auth_part_verbatim=>"Movss. 1967"}
    pos(sn).should == {3=>["genus", 15], 19=>["species", 28], 39=>["subspecies", 46], 50=>["author_word", 56], 59=>["year", 63]}
  end
  
  it "should parse name with several subspecies names NOT BOTANICAL CODE BUT NOT INFREQUENT" do
    sn = "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall et D.E. Stuntz 1972"
    details(sn).should ==  {:genus=>"Hydnellum", :species=>"scrobiculatum", :subspecies=>[{:rank=>"var.", :value=>"zonatum"}, {:rank=>"f.", :value=>"parvum"}], :is_valid=>false, :orig_authors=>{:names=>["Banker"]}, :authors=>{:names=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :name_part_verbatim=>"Hydnellum scrobiculatum var. zonatum f. parvum", :auth_part_verbatim=>"(Banker) D. Hall & D.E. Stuntz 1972"}
    pos(sn).should ==  {0=>["genus", 9], 10=>["species", 23], 29=>["subspecies", 36], 40=>["subspecies", 46], 48=>["author_word", 54], 56=>["author_word", 58], 59=>["author_word", 63], 66=>["author_word", 70], 71=>["author_word", 77], 78=>["year", 82]}
  end
  
  it "should parse status BOTANICAL RARE" do
    #it is always latin abbrev often 2 words
    sn = "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should ==  {:genus=>"Arthopyrenia", :species=>"hyalospora", :orig_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["R.C. Harris"]}, :status=>"comb. nov.", :name_part_verbatim=>"Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl.) R.C. Harris comb. nov."}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 31=>["author_word", 35], 36=>["author_word", 42]}
  end
  
  it "should parse name without a year but with authors" do 
    sn = "Arthopyrenia hyalospora(Nyl.)R.C.     Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 24=>["author_word", 28], 29=>["author_word", 33], 38=>["author_word", 44]}
  end
  
  it "should parse revised (ex) names" do
    #invalidly published
    sn = "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:genus=>"Arthopyrenia", :species=>"hyalospora", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 33=>["author_word", 39], 41=>["author_word", 45], 46=>["author_word", 52]}
    
    parse("Arthopyrenia hyalospora Nyl. ex Banker").should_not be_nil
    sn = "Glomopsis lonicerae Peck ex C.J. Gould 1945"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Glomopsis", :species=>"lonicerae", :revised_name_authors=>{:revised_authors=>{:names=>["Peck"]}, :authors=>{:names=>["C.J. Gould"], :year=>"1945"}}, :name_part_verbatim=>"Glomopsis lonicerae", :auth_part_verbatim=>"Peck ex C.J. Gould 1945"}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 20=>["author_word", 24], 28=>["author_word", 32], 33=>["author_word", 38], 39=>["year", 43]}
    parse("Acanthobasidium delicatum (Wakef.) Oberw. ex Jülich 1979").should_not be_nil
    sn = "Mycosphaerella eryngii (Fr. ex Duby) Johanson ex Oudem. 1897"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Mycosphaerella", :species=>"eryngii", :original_revised_name_authors=>{:revised_authors=>{:names=>["Fr."]}, :authors=>{:names=>["Duby"]}}, :revised_name_authors=>{:revised_authors=>{:names=>["Johanson"]}, :authors=>{:names=>["Oudem."], :year=>"1897"}}, :name_part_verbatim=>"Mycosphaerella eryngii", :auth_part_verbatim=>"(Fr. ex Duby) Johanson ex Oudem. 1897"}
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22], 24=>["author_word", 27], 31=>["author_word", 35], 37=>["author_word", 45], 49=>["author_word", 55], 56=>["year", 60]}
    #invalid but happens
    parse("Mycosphaerella eryngii (Fr. Duby) ex Oudem. 1897").should_not be_nil
    parse("Mycosphaerella eryngii (Fr.ex Duby) ex Oudem. 1897").should_not be_nil
    sn = "Salmonella werahensis (Castellani) Hauduroy and Ehringer in Hauduroy 1937"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 10], 11=>["species", 21], 23=>["author_word", 33], 35=>["author_word", 43], 48=>["author_word", 56], 60=>["author_word", 68], 69=>["year", 73]}
  end
  
  it "should parse multiplication sign" do
    sn = "Arthopyrenia x hyalospora (Nyl.) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Arthopyrenia", :species=>"hyalospora", :cross=>"inside", :orig_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"Arthopyrenia x hyalospora", :auth_part_verbatim=>"(Nyl.) R.C. Harris"}
    pos(sn).should == {0=>["genus", 12], 15=>["species", 25], 27=>["author_word", 31], 33=>["author_word", 37], 38=>["author_word", 44]}
    parse("Arthopyrenia X hyalospora(Nyl. ex Banker) R.C. Harris").should_not be_nil
    sn = "x Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should ==  {:genus=>"Arthopyrenia", :species=>"hyalospora", :cross=>"before", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"x Arthopyrenia hyalospora", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {2=>["genus", 14], 15=>["species", 25], 27=>["author_word", 31], 35=>["author_word", 41], 43=>["author_word", 47], 48=>["author_word", 54]}
    sn = "X Arthopyrenia (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    details(sn).should == {:uninomial=>"Arthopyrenia", :cross=>"before", :original_revised_name_authors=>{:revised_authors=>{:names=>["Nyl."]}, :authors=>{:names=>["Banker"]}}, :authors=>{:names=>["R.C. Harris"]}, :name_part_verbatim=>"X Arthopyrenia", :auth_part_verbatim=>"(Nyl. ex Banker) R.C. Harris"}
    pos(sn).should == {2=>["uninomial", 14], 16=>["author_word", 20], 24=>["author_word", 30], 32=>["author_word", 36], 37=>["author_word", 43]}
    #ascii for multiplication
    parse("Melampsora × columbiana G. Newc. 2000").should_not be_nil
  end
  
  it "should parse hybrid combination" do
    sn = "Arthopyrenia hyalospora X Hydnellum scrobiculatum"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    canonical(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>{:species=>"scrobiculatum", :genus=>"Hydnellum"}}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 26=>["genus", 35], 36=>["species", 49]}
    sn = "Arthopyrenia hyalospora (Banker) D. Hall X Hydnellum scrobiculatum D.E. Stuntz"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Banker) D. Hall \303\227 Hydnellum scrobiculatum D.E. Stuntz"
    canonical(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 31], 33=>["author_word", 35], 36=>["author_word", 40], 43=>["genus", 52], 53=>["species", 66], 67=>["author_word", 71], 72=>["author_word", 78]}
    value("Arthopyrenia hyalospora X").should == "Arthopyrenia hyalospora \303\227 ?"  
    sn = "Arthopyrenia hyalospora x"
    parse(sn).should_not be_nil
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>"?"}}  
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
    sn = "Arthopyrenia hyalospora × ?"
    parse(sn).should_not be_nil
    details(sn).should == {:hybrid=>{:scientific_name1=>{:species=>"hyalospora", :genus=>"Arthopyrenia"}, :scientific_name2=>"?"}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
  end

  

  it "should parse name with subspecies without rank NOT BOTANICAL" do
    sn = "Hydnellum scrobiculatum zonatum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum zonatum (Banker) D. Hall et D.E. Stuntz 1972"
    canonical(sn).should == "Hydnellum scrobiculatum zonatum"
    details(sn).should == {:genus=>"Hydnellum", :species=>"scrobiculatum", :subspecies=>{:rank=>"n/a", :value=>"zonatum"}, :orig_authors=>{:names=>["Banker"]}, :authors=>{:names=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :name_part_verbatim=>"Hydnellum scrobiculatum zonatum", :auth_part_verbatim=>"(Banker) D. Hall & D.E. Stuntz 1972"}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 23], 24=>["subspecies", 31], 33=>["author_word", 39], 41=>["author_word", 43], 44=>["author_word", 48], 51=>["author_word", 55], 56=>["author_word", 62], 63=>["year", 67]}
    sn = "Begonia pingbienensis angustior"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>"Begonia", :species=>"pingbienensis", :subspecies=>{:rank=>"n/a", :value=>"angustior"}}
    pos(sn).should == {0=>["genus", 7], 8=>["species", 21], 22=>["subspecies", 31]}
  end
  
  it "should not parse unallowed utf-8 chars in name part" do
    parse("Érematosphaeria phaespora").should be_nil
    parse("Trematosphaeria phaeáapora").should be_nil
    parse("Trematоsphaeria phaeáapora").should be_nil #cyrillic o
  end
  
  it "should parse some invalid names" do
    parse("Acarospora cratericola 1929").should_not be_nil
    parse("Agaricus acris var. (b.)").should_not be_nil  
    value("Agaricus acris var. (b.)").should == "Agaricus acris var. (b.)"  
    parse("Agaricus acris var. (b.)").should_not be_nil 
    sn = "Agaricus acris var. (b.&c.)"
    value(sn).should == "Agaricus acris var. (b.c.)"  
    details(sn).should == {:editorial_markup=>"(b.c.)", :subspecies=>[{:rank=>"var.", :value=>nil}], :species=>"acris", :genus=>"Agaricus", :is_valid=>false}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 14]}
  end

  it 'should parse double parenthesis' do
    sn = "Eichornia crassipes ( (Martius) ) Solms-Laub."
    parse(sn).should_not be_nil
    value(sn).should == "Eichornia crassipes (Martius) Solms-Laub."
    details(sn).should == {:genus=>"Eichornia", :species=>"crassipes", :orig_authors=>{:names=>["Martius"]}, :authors=>{:names=>["Solms-Laub."]}, :name_part_verbatim=>"Eichornia crassipes", :auth_part_verbatim=>"( (Martius) ) Solms-Laub."}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 23=>["author_word", 30], 34=>["author_word", 45]} 
  end

#  val = "Ferganoconcha? oblonga"
  it 'should parse genus?' do
    sn = "Ferganoconcha? oblonga"
    parse(sn).should_not be_nil
    value(sn).should == "Ferganoconcha oblonga"
    details(sn).should == {:genus=>"Ferganoconcha", :species=>"oblonga"}   
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22]}
  end
  
end
