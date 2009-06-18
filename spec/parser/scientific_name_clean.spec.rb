# encoding: UTF-8
dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'yaml'
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
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora"}}
    pos(sn).should == {0=>["uninomial", 16]}
  end
  
  it 'should parse uninomial with author and year' do
    sn = 'Pseudocercospora Speg.'
    parse(sn).should_not be_nil
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora", :authorship=>"Speg.", :basionymAuthorTeam=>{:authorTeam=>"Speg.", :author=>["Speg."]}}}
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 22]}    
    sn = 'Pseudocercospora Spegazzini, 1910'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora Spegazzini 1910'
    details(sn).should == {:uninomial=>{:epitheton=>"Pseudocercospora", :authorship=>"Spegazzini, 1910", :basionymAuthorTeam=>{:authorTeam=>"Spegazzini", :author=>["Spegazzini"], :year=>"1910"}}}
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 27], 29=>["year", 33]}
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
  
  it 'should parse canonical' do
    sn = 'Pseudocercospora     dendrobii'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora dendrobii'
    canonical(sn).should == 'Pseudocercospora dendrobii'
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii"}}
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
  end
  
  
  it 'should parse species name with author and year' do
    sn = "Platypus bicaudatulus Schedl 1935"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    sn = "Platypus bicaudatulus Schedl, 1935h"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    details(sn).should == {:genus=>{:epitheton=>"Platypus"}, :species=>{:epitheton=>"bicaudatulus", :authorship=>"Schedl, 1935h", :basionymAuthorTeam=>{:authorTeam=>"Schedl", :author=>["Schedl"], :year=>"1935"}}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 22=>["author_word", 28], 30=>["year", 35]}
    parse("Platypus bicaudatulus Schedl, 1935B").should_not be_nil
    sn = "Platypus bicaudatulus Schedl (1935h)"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Platypus"}, :species=>{:epitheton=>"bicaudatulus", :authorship=>"Schedl (1935h)", :basionymAuthorTeam=>{:authorTeam=>"Schedl", :author=>["Schedl"], :year=>"1935"}}}
    parse("Platypus bicaudatulus Schedl 1935").should_not be_nil
  end
  
  it 'should parse genus with "?"' do
    sn = "Ferganoconcha? oblonga"
    parse(sn).should_not be_nil
    value(sn).should == "Ferganoconcha oblonga"
    details(sn).should == {:genus=>{:epitheton=>"Ferganoconcha"}, :species=>{:epitheton=>"oblonga"}}
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22]}
  end
  
  it 'should parse æ in the name' do
    names = [
      ["Læptura laetifica Dow, 1913", "Laeptura laetifica Dow 1913"],
      ["Leptura lætifica Dow, 1913", "Leptura laetifica Dow 1913"],
      ["Leptura leætifica Dow, 1913", "Leptura leaetifica Dow 1913"],
      ["Leæptura laetifica Dow, 1913", "Leaeptura laetifica Dow 1913"],
      ["Leœptura laetifica Dow, 1913", "Leoeptura laetifica Dow 1913"],
      ['Ærenea cognata Lacordaire, 1872', 'Aerenea cognata Lacordaire 1872'],
      ['Œdicnemus capensis', 'Oedicnemus capensis'],
      ['Œnanthe œnanthe','Oenanthe oenanthe']
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
    sn = "Trematosphaeria phaeospora (E. Müll.)         L.             Holm 1957"
    parse(sn).should_not be_nil
    value(sn).should == "Trematosphaeria phaeospora (E. Müll.) L. Holm 1957"
    canonical(sn).should == "Trematosphaeria phaeospora"
    details(sn).should == {:genus=>{:epitheton=>"Trematosphaeria"}, :species=>{:epitheton=>"phaeospora", :authorship=>"(E. Müll.)         L.             Holm 1957", :combinationAuthorTeam=>{:authorTeam=>"L.             Holm", :author=>["L. Holm"], :year=>"1957"}, :basionymAuthorTeam=>{:authorTeam=>"E. Müll.", :author=>["E. Müll."]}}}
    pos(sn).should == {0=>["genus", 15], 16=>["species", 26], 28=>["author_word", 30], 31=>["author_word", 36], 46=>["author_word", 48], 61=>["author_word", 65], 66=>["year", 70]}
    
  end
    
  it 'should parse subgenus (ICZN code)' do
    sn = "Hegeter (Hegeter) intercedens Lindberg H 1950"
    parse(sn).should_not be_nil
    value(sn).should == "Hegeter (Hegeter) intercedens Lindberg H 1950"
    canonical(sn).should == "Hegeter intercedens"
    details(sn).should == {:genus=>{:epitheton=>"Hegeter"}, :subgenus=>{:epitheton=>"Hegeter"}, :species=>{:epitheton=>"intercedens", :authorship=>"Lindberg H 1950", :basionymAuthorTeam=>{:authorTeam=>"Lindberg H", :author=>["Lindberg H"], :year=>"1950"}}}
    pos(sn).should == {0=>["genus", 7], 9=>["subgenus", 16], 18=>["species", 29], 30=>["author_word", 38], 39=>["author_word", 40], 41=>["year", 45]}
  end
  
  it 'should parse several authors without a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should ==  {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"U. Braun & Crous", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"]}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43]}
    sn = "Pseudocercospora dendrobii U. Braun and Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 40=>["author_word", 45]}
    sn = "Pseudocercospora dendrobii U. Braun et Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"    
    sn = "Arthopyrenia hyalospora(Nyl.)R.C.     Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora", :authorship=>"(Nyl.)R.C.     Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C.     Harris", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."]}}}
  end
  
  

  it 'should parse several authors with a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"U. Braun & Crous 2003", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43], 44=>["year", 48]}
    sn = "Pseudocercospora dendrobii Crous, 2003"
    parse(sn).should_not be_nil
  end
  
  it 'should parse basionym authors in parenthesis' do
    sn = "Zophosis persis (Chatanay, 1914)"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay, 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}
    sn = "Zophosis persis (Chatanay 1914)"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}
    sn = "Zophosis persis (Chatanay), 1914"
    parse(sn).should_not be_nil
    value(sn).should == "Zophosis persis (Chatanay 1914)"
    details(sn).should == {:genus=>{:epitheton=>"Zophosis"}, :species=>{:epitheton=>"persis", :authorship=>"(Chatanay), 1914", :basionymAuthorTeam=>{:author_team=>"(Chatanay), 1914", :author=>["Chatanay"], :year=>"1914"}}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 15], 17=>["author_word", 25], 28=>["year", 32]}
    parse("Zophosis persis (Chatanay) 1914").should_not be_nil
    #parse("Zophosis persis Chatanay (1914)").should_not be_nil
  end  
  
  it 'should parse scientific name' do
    sn = "Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C.     Burnett)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"]}}}
    sn = "Pseudocercospora dendrobii(H.C.     Burnett,1873)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1873) U. Braun et Crous 2003"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C.     Burnett,1873)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"], :year=>"1873"}}}
  end
  
  it 'should parse several authors with several years' do
    sn = "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == {:genus=>{:epitheton=>"Pseudocercospora"}, :species=>{:epitheton=>"dendrobii", :authorship=>"(H.C. Burnett 1883) U. Braun & Crous 2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C. Burnett", :author=>["H.C. Burnett"], :year=>"1883"}}}
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 28=>["author_word", 32], 33=>["author_word", 40], 41=>["year", 45], 47=>["author_word", 49], 50=>["author_word", 55], 58=>["author_word", 63], 64=>["year", 68]}
  end

  it "should parse name with subspecies without rank Zoological Code" do
    sn = "Hydnellum scrobiculatum zonatum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum zonatum (Banker) D. Hall et D.E. Stuntz 1972"
    canonical(sn).should == "Hydnellum scrobiculatum zonatum"
    details(sn).should == {:genus=>{:epitheton=>"Hydnellum"}, :species=>{:epitheton=>"scrobiculatum"}, :infraspecies=>{:epitheton=>"zonatum", :rank=>"n/a", :authorship=>"(Banker) D. Hall & D.E. Stuntz 1972", :combinationAuthorTeam=>{:authorTeam=>"D. Hall & D.E. Stuntz", :author=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :basionymAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 23], 24=>["infraspecies", 31], 33=>["author_word", 39], 41=>["author_word", 43], 44=>["author_word", 48], 51=>["author_word", 55], 56=>["author_word", 62], 63=>["year", 67]}
    sn = "Begonia pingbienensis angustior"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Begonia"}, :species=>{:epitheton=>"pingbienensis"}, :infraspecies=>{:epitheton=>"angustior", :rank=>"n/a"}}
    pos(sn).should == {0=>["genus", 7], 8=>["species", 21], 22=>["infraspecies", 31]}
  end

  it 'should parse infraspecies with rank' do
    sn = "Aus bus Linn. var. bus"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Aus"}, :species=>{:epitheton=>"bus", :authorship=>"Linn.", :basionymAuthorTeam=>{:authorTeam=>"Linn.", :author=>["Linn."]}}, :infraspecies=>{:epitheton=>"bus", :rank=>"var."}}
    sn = "Agalinis purpurea (L.) Briton var. borealis (Berg.) Peterson 1987"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Agalinis"}, :species=>{:epitheton=>"purpurea", :authorship=>"(L.) Briton", :combinationAuthorTeam=>{:authorTeam=>"Briton", :author=>["Briton"]}, :basionymAuthorTeam=>{:authorTeam=>"L.", :author=>["L."]}}, :infraspecies=>{:epitheton=>"borealis", :rank=>"var.", :authorship=>"(Berg.) Peterson 1987", :combinationAuthorTeam=>{:authorTeam=>"Peterson", :author=>["Peterson"], :year=>"1987"}, :basionymAuthorTeam=>{:authorTeam=>"Berg.", :author=>["Berg."]}}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 17], 19=>["author_word", 21], 23=>["author_word", 29], 35=>["infraspecies", 43], 45=>["author_word", 50], 52=>["author_word", 60], 61=>["year", 65]}
    sn = "Phaeographis inusta var. macularis(Leight.) A.L. Sm. 1861"
    parse(sn).should_not be_nil
    value(sn).should == "Phaeographis inusta var. macularis (Leight.) A.L. Sm. 1861"
    canonical(sn).should == "Phaeographis inusta macularis"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 19], 25=>["infraspecies", 34], 35=>["author_word", 42], 44=>["author_word", 48], 49=>["author_word", 52], 53=>["year", 57]}
  end

  it 'should parse unknown original authors (auct.)/(hort.)/(?)' do
    sn = "Tragacantha leporina (?) Kuntze"
    parse(sn).should_not be_nil
    value(sn).should == "Tragacantha leporina (?) Kuntze"
    details(sn).should == {:genus=>{:epitheton=>"Tragacantha"}, :species=>{:epitheton=>"leporina", :authorship=>"(?) Kuntze", :combinationAuthorTeam=>{:authorTeam=>"Kuntze", :author=>["Kuntze"]}, :basionymAuthorTeam=>{:authorTeam=>"(?)", :author=>["?"]}}}
    sn = "Lachenalia tricolor var. nelsonii (auct.) Baker"
    parse(sn).should_not be_nil
    value(sn).should == "Lachenalia tricolor var. nelsonii (auct.) Baker"
    details(sn).should == {:genus=>{:epitheton=>"Lachenalia"}, :species=>{:epitheton=>"tricolor"}, :infraspecies=>{:epitheton=>"nelsonii", :rank=>"var.", :authorship=>"(auct.) Baker", :combinationAuthorTeam=>{:authorTeam=>"Baker", :author=>["Baker"]}, :basionymAuthorTeam=>{:authorTeam=>"auct.", :author=>["unknown"]}}}
    pos(sn).should == {0=>["genus", 10], 11=>["species", 19], 25=>["infraspecies", 33], 35=>["unknown_author", 40], 42=>["author_word", 47]}
  end  
  
  it 'should parse unknown authors auct./anon./hort./ht.' do
    sn = "Puya acris ht."
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 4], 5=>["species", 10], 11=>["unknown_author", 14]}
  end
  
  it 'shuould parse real world examples' do
    sn = "Stagonospora polyspora M.T. Lucas & Sousa da Câmara 1934"
    parse(sn).should_not be_nil
    value(sn).should == "Stagonospora polyspora M.T. Lucas et Sousa da Câmara 1934"
    details(sn).should == {:genus=>{:epitheton=>"Stagonospora"}, :species=>{:epitheton=>"polyspora", :authorship=>"M.T. Lucas & Sousa da Câmara 1934", :basionymAuthorTeam=>{:authorTeam=>"M.T. Lucas & Sousa da Câmara", :author=>["M.T. Lucas", "Sousa da Câmara"], :year=>"1934"}}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 22], 23=>["author_word", 27], 28=>["author_word", 33], 36=>["author_word", 41], 42=>["author_word", 44], 45=>["author_word", 51], 52=>["year", 56]}
    parse("Cladoniicola staurospora Diederich, van den Boom & Aptroot 2001").should_not be_nil
    sn = "Yarrowia lipolytica var. lipolytica (Wick., Kurtzman & E.A. Herrm.) Van der Walt & Arx 1981"
    parse(sn).should_not be_nil
    value(sn).should == "Yarrowia lipolytica var. lipolytica (Wick., Kurtzman et E.A. Herrm.) Van der Walt et Arx 1981"
    pos(sn).should == {0=>["genus", 8], 9=>["species", 19], 25=>["infraspecies", 35], 37=>["author_word", 42], 44=>["author_word", 52], 55=>["author_word", 59], 60=>["author_word", 66], 68=>["author_word", 71], 72=>["author_word", 75], 76=>["author_word", 80], 83=>["author_word", 86], 87=>["year", 91]}
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
    details(sn).should == {:genus=>{:epitheton=>"Tuber"}, :species=>{:epitheton=>"liui", :authorship=>"A S. Xu 1999", :basionymAuthorTeam=>{:authorTeam=>"A S. Xu", :author=>["A S. Xu"], :year=>"1999"}}}
    parse('Xylaria potentillae A S. Xu').should_not be_nil
    parse("Agaricus squamula Berk. & M.A. Curtis 1860").should_not be_nil
    parse("Peltula coriacea Büdel, Henssen & Wessels 1986").should_not be_nil
    #had to add no dot rule for trinomials without a rank to make it to work
    sn = "Saccharomyces drosophilae anon."
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Saccharomyces"}, :species=>{:epitheton=>"drosophilae", :authorship=>"anon.", :basionymAuthorTeam=>{:authorTeam=>"anon.", :author=>["unknown"]}}}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 26=>["unknown_author", 31]}
    sn = "Abacetus laevicollis de Chaudoir, 1869"
    parse(sn).should_not be_nil
    canonical(sn).should == 'Abacetus laevicollis'
    sn = "Gastrosericus eremorum van Beaumont 1955"
    canonical(sn).should == 'Gastrosericus eremorum'
    sn = "Gastrosericus eremorum von Beaumont 1955"
    canonical(sn).should == 'Gastrosericus eremorum'
    sn = "Cypraeovula (Luponia) amphithales perdentata"
    canonical(sn).should == 'Cypraeovula amphithales perdentata'
    details(sn).should == {:genus=>{:epitheton=>"Cypraeovula"}, :subgenus=>{:epitheton=>"Luponia"}, :species=>{:epitheton=>"amphithales"}, :infraspecies=>{:epitheton=>"perdentata", :rank=>"n/a"}}
    sn = "Polyrhachis orsyllus nat musculus Forel 1901"
    canonical(sn).should == "Polyrhachis orsyllus musculus"
    sn = 'Latrodectus 13-guttatus Thorell, 1875'
    canonical(sn).should == 'Latrodectus 13-guttatus'
    value(sn).should == 'Latrodectus 13-guttatus Thorell 1875'
    sn = 'Latrodectus 3guttatus Thorell, 1875'
    canonical(sn).should == 'Latrodectus 3-guttatus'
    value(sn).should == 'Latrodectus 3-guttatus Thorell 1875'
  end

  it "should parse name with morph." do
    sn = "Callideriphus flavicollis morph. reductus Fuchs 1961"
    parse(sn).should_not be_nil
    value(sn).should == "Callideriphus flavicollis morph. reductus Fuchs 1961"
    canonical(sn).should == "Callideriphus flavicollis reductus"
    details(sn).should == {:genus=>{:epitheton=>"Callideriphus"}, :species=>{:epitheton=>"flavicollis"}, :infraspecies=>{:epitheton=>"reductus", :rank=>"morph.", :authorship=>"Fuchs 1961", :basionymAuthorTeam=>{:authorTeam=>"Fuchs", :author=>["Fuchs"], :year=>"1961"}}}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 33=>["infraspecies", 41], 42=>["author_word", 47], 48=>["year", 52]}
  end

  
  it "should parse name with forma/fo./form./f." do
    sn = "Caulerpa cupressoides forma nuda"
    parse(sn).should_not be_nil
    value(sn).should == "Caulerpa cupressoides f. nuda"
    canonical(sn).should == "Caulerpa cupressoides nuda"
    details(sn).should == {:genus=>{:epitheton=>"Caulerpa"}, :species=>{:epitheton=>"cupressoides"}, :infraspecies=>{:epitheton=>"nuda", :rank=>"f."}}
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 28=>["infraspecies", 32]}
    sn = "Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó"
    parse(sn).should_not be_nil
    value("Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó").should == "Chlorocyperus glaber f. fasciculariforme (Lojac.) Soó"
    canonical(sn).should == "Chlorocyperus glaber fasciculariforme"
    details(sn).should == {:genus=>{:epitheton=>"Chlorocyperus"}, :species=>{:epitheton=>"glaber"}, :infraspecies=>{:epitheton=>"fasciculariforme", :rank=>"f.", :authorship=>"(Lojac.) Soó", :combinationAuthorTeam=>{:authorTeam=>"Soó", :author=>["Soó"]}, :basionymAuthorTeam=>{:authorTeam=>"Lojac.", :author=>["Lojac."]}}}
    pos(sn).should == {0=>["genus", 13], 14=>["species", 20], 27=>["infraspecies", 43], 45=>["author_word", 51], 53=>["author_word", 56]}
    sn = "Bambusa nana Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    parse(sn).should_not be_nil
    value(sn).should == "Bambusa nana Roxb. f. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    canonical(sn).should == "Bambusa nana alphonse-karri"
    details(sn).should == {:genus=>{:epitheton=>"Bambusa"}, :species=>{:epitheton=>"nana", :authorship=>"Roxb.", :basionymAuthorTeam=>{:authorTeam=>"Roxb.", :author=>["Roxb."]}}, :infraspecies=>{:epitheton=>"alphonse-karri", :rank=>"f.", :authorship=>"(Mitford ex Satow) Makino ex Shiros.", :combinationAuthorTeam=>{:authorTeam=>"Makino", :author=>["Makino"], :exAuthorTeam=>{:authorTeam=>"Shiros.", :author=>["Shiros."]}}, :basionymAuthorTeam=>{:authorTeam=>"Mitford", :author=>["Mitford"], :exAuthorTeam=>{:authorTeam=>"Satow", :author=>["Satow"]}}}}
    pos(sn).should ==  {0=>["genus", 7], 8=>["species", 12], 13=>["author_word", 18], 23=>["infraspecies", 37], 39=>["author_word", 46], 50=>["author_word", 55], 57=>["author_word", 63], 67=>["author_word", 74]}
    sn = "   Sphaerotheca    fuliginea     f.    dahliae    Movss.   1967    "
    sn = "Sphaerotheca    fuliginea    f.     dahliae    Movss.     1967"
    parse(sn).should_not be_nil
    value(sn).should == "Sphaerotheca fuliginea f. dahliae Movss. 1967"
    canonical(sn).should == "Sphaerotheca fuliginea dahliae"
    details(sn).should ==  {:genus=>{:epitheton=>"Sphaerotheca"}, :species=>{:epitheton=>"fuliginea"}, :infraspecies=>{:epitheton=>"dahliae", :rank=>"f.", :authorship=>"Movss.     1967", :basionymAuthorTeam=>{:authorTeam=>"Movss.", :author=>["Movss."], :year=>"1967"}}}
    pos(sn).should == {0=>["genus", 12], 16=>["species", 25], 36=>["infraspecies", 43], 47=>["author_word", 53], 58=>["year", 62]}
    parse('Polypodium vulgare nothosubsp. mantoniae (Rothm.) Schidlay').should_not be_nil
  end
  
  it "should parse name with several subspecies names NOT BOTANICAL CODE BUT NOT INFREQUENT" do
    sn = "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall et D.E. Stuntz 1972"
    details(sn).should ==  {:genus=>{:epitheton=>"Hydnellum"}, :species=>{:epitheton=>"scrobiculatum"}, :infraspecies=>[{:epitheton=>"zonatum", :rank=>"var."}, {:epitheton=>"parvum", :rank=>"f.", :authorship=>"(Banker) D. Hall & D.E. Stuntz 1972", :combinationAuthorTeam=>{:authorTeam=>"D. Hall & D.E. Stuntz", :author=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :basionymAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}]}
    pos(sn).should ==  {0=>["genus", 9], 10=>["species", 23], 29=>["infraspecies", 36], 40=>["infraspecies", 46], 48=>["author_word", 54], 56=>["author_word", 58], 59=>["author_word", 63], 66=>["author_word", 70], 71=>["author_word", 77], 78=>["year", 82]}
    parse('Senecio fuchsii C.C.Gmel. subsp. fuchsii var. expansus (Boiss. & Heldr.) Hayek').should_not be_nil
    parse('Senecio fuchsii C.C.Gmel. subsp. fuchsii var. fuchsii').should_not be_nil
  end
  
  
  it "should parse status BOTANICAL RARE" do
    #it is always latin abbrev often 2 words
    sn = "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov."
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should ==  {:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora", :authorship=>"(Nyl.) R.C. Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C. Harris ", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."]}}, :status=>"comb. nov."}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 31=>["author_word", 35], 36=>["author_word", 42]}
  end
  
  it "should parse revised (ex) names" do
    #invalidly published
    sn = "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora", :authorship=>"(Nyl. ex Banker) R.C. Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C. Harris", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."], :exAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 33=>["author_word", 39], 41=>["author_word", 45], 46=>["author_word", 52]}
    sn = "Arthopyrenia hyalospora Nyl. ex Banker"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora", :authorship=>"Nyl. ex Banker", :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."], :exAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}}
    sn = "Glomopsis lonicerae Peck ex C.J. Gould 1945"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Glomopsis"}, :species=>{:epitheton=>"lonicerae", :authorship=>"Peck ex C.J. Gould 1945", :basionymAuthorTeam=>{:authorTeam=>"Peck", :author=>["Peck"], :exAuthorTeam=>{:authorTeam=>"C.J. Gould", :author=>["C.J. Gould"], :year=>"1945"}}}}
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 20=>["author_word", 24], 28=>["author_word", 32], 33=>["author_word", 38], 39=>["year", 43]}
    parse("Acanthobasidium delicatum (Wakef.) Oberw. ex Jülich 1979").should_not be_nil
    sn = "Mycosphaerella eryngii (Fr. ex Duby) Johanson ex Oudem. 1897"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Mycosphaerella"}, :species=>{:epitheton=>"eryngii", :authorship=>"(Fr. ex Duby) Johanson ex Oudem. 1897", :combinationAuthorTeam=>{:authorTeam=>"Johanson", :author=>["Johanson"], :exAuthorTeam=>{:authorTeam=>"Oudem.", :author=>["Oudem."], :year=>"1897"}}, :basionymAuthorTeam=>{:authorTeam=>"Fr.", :author=>["Fr."], :exAuthorTeam=>{:authorTeam=>"Duby", :author=>["Duby"]}}}}
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22], 24=>["author_word", 27], 31=>["author_word", 35], 37=>["author_word", 45], 49=>["author_word", 55], 56=>["year", 60]}
    #invalid but happens
    parse("Mycosphaerella eryngii (Fr. Duby) ex Oudem. 1897").should_not be_nil
    parse("Mycosphaerella eryngii (Fr.ex Duby) ex Oudem. 1897").should_not be_nil
    sn = "Salmonella werahensis (Castellani) Hauduroy and Ehringer in Hauduroy 1937"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Salmonella"}, :species=>{:epitheton=>"werahensis", :authorship=>"(Castellani) Hauduroy and Ehringer in Hauduroy 1937", :combinationAuthorTeam=>{:authorTeam=>"Hauduroy and Ehringer", :author=>["Hauduroy", "Ehringer"], :exAuthorTeam=>{:authorTeam=>"Hauduroy", :author=>["Hauduroy"], :year=>"1937"}}, :basionymAuthorTeam=>{:authorTeam=>"Castellani", :author=>["Castellani"]}}}
    pos(sn).should == {0=>["genus", 10], 11=>["species", 21], 23=>["author_word", 33], 35=>["author_word", 43], 48=>["author_word", 56], 60=>["author_word", 68], 69=>["year", 73]}
  end
    
  it 'should parse named hybrids' do
    [
      ["×Agropogon P. Fourn. 1934", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon", :authorship=>"P. Fourn. 1934", :basionymAuthorTeam=>{:authorTeam=>"P. Fourn.", :author=>["P. Fourn."], :year=>"1934"}}}}],
      ["xAgropogon P. Fourn.", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon", :authorship=>"P. Fourn.", :basionymAuthorTeam=>{:authorTeam=>"P. Fourn.", :author=>["P. Fourn."]}}}}],
      ["XAgropogon P.Fourn.", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon", :authorship=>"P.Fourn.", :basionymAuthorTeam=>{:authorTeam=>"P.Fourn.", :author=>["P.Fourn."]}}}}],
      ["× Agropogon", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon"}}}],
      ["x Agropogon", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon"}}}],
      ["X Agropogon", {:namedHybrid=>{:uninomial=>{:epitheton=>"Agropogon"}}}],
      ["X Cupressocyparis leylandii", {:namedHybrid=>{:genus=>{:epitheton=>"Cupressocyparis"}, :species=>{:epitheton=>"leylandii"}}}],
      ["×Heucherella tiarelloides", {:namedHybrid=>{:genus=>{:epitheton=>"Heucherella"}, :species=>{:epitheton=>"tiarelloides"}}}],
      ["xHeucherella tiarelloides", {:namedHybrid=>{:genus=>{:epitheton=>"Heucherella"}, :species=>{:epitheton=>"tiarelloides"}}}],
      ["x Heucherella tiarelloides", {:namedHybrid=>{:genus=>{:epitheton=>"Heucherella"}, :species=>{:epitheton=>"tiarelloides"}}}],
      ["×Agropogon littoralis (Sm.) C. E. Hubb. 1946", {:namedHybrid=>{:genus=>{:epitheton=>"Agropogon"}, :species=>{:epitheton=>"littoralis", :authorship=>"(Sm.) C. E. Hubb. 1946", :combinationAuthorTeam=>{:authorTeam=>"C. E. Hubb.", :author=>["C. E. Hubb."], :year=>"1946"}, :basionymAuthorTeam=>{:authorTeam=>"Sm.", :author=>["Sm."]}}}}]
    ].each do |res| 
      parse(res[0]).should_not be_nil
      details(res[0]).should == res[1]
    end
   [ 
    ['Asplenium X inexpectatum (E.L. Braun 1940) Morton (1956)',{:genus=>{:epitheton=>"Asplenium"}, :species=>{:epitheton=>"inexpectatum", :namedHybrid=>true, :authorship=>"(E.L. Braun 1940) Morton (1956)", :combinationAuthorTeam=>{:authorTeam=>"Morton", :author=>["Morton"], :year=>"1956"}, :basionymAuthorTeam=>{:authorTeam=>"E.L. Braun", :author=>["E.L. Braun"], :year=>"1940"}}}],
    ['Mentha ×smithiana R. A. Graham 1949',{:genus=>{:epitheton=>"Mentha"}, :species=>{:epitheton=>"smithiana", :namedHybrid=>true, :authorship=>"R. A. Graham 1949", :basionymAuthorTeam=>{:authorTeam=>"R. A. Graham", :author=>["R. A. Graham"], :year=>"1949"}}}],
    ['Salix ×capreola Andersson (1867)',{:genus=>{:epitheton=>"Salix"}, :species=>{:epitheton=>"capreola", :namedHybrid=>true, :authorship=>"Andersson (1867)", :basionymAuthorTeam=>{:authorTeam=>"Andersson", :author=>["Andersson"], :year=>"1867"}}}],
    ['Salix x capreola Andersson',{:genus=>{:epitheton=>"Salix"}, :species=>{:epitheton=>"capreola", :namedHybrid=>true, :authorship=>"Andersson", :basionymAuthorTeam=>{:authorTeam=>"Andersson", :author=>["Andersson"]}}}]
   ].each do |res|
      parse(res[0]).should_not be_nil
      details(res[0]).should == res[1]
   end
  end
  
  it "should parse hybrid combination" do
    sn = "Arthopyrenia hyalospora X Hydnellum scrobiculatum"
    parse(sn).should_not be_nil    
    value(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    canonical(sn).should == "Arthopyrenia hyalospora Hydnellum scrobiculatum"
    details(sn).should == {:hybridFormula=>[{:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora"}}, {:genus=>{:epitheton=>"Hydnellum"}, :species=>{:epitheton=>"scrobiculatum"}}]}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 26=>["genus", 35], 36=>["species", 49]}
    sn = "Arthopyrenia hyalospora (Banker) D. Hall X Hydnellum scrobiculatum D.E. Stuntz"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Banker) D. Hall \303\227 Hydnellum scrobiculatum D.E. Stuntz"
    canonical(sn).should == "Arthopyrenia hyalospora Hydnellum scrobiculatum"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 31], 33=>["author_word", 35], 36=>["author_word", 40], 43=>["genus", 52], 53=>["species", 66], 67=>["author_word", 71], 72=>["author_word", 78]}
    value("Arthopyrenia hyalospora X").should == "Arthopyrenia hyalospora \303\227 ?"  
    sn = "Arthopyrenia hyalospora x"
    parse(sn).should_not be_nil
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == {:hybridFormula=>[{:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora"}}, "?"]}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
    sn = "Arthopyrenia hyalospora × ?"
    parse(sn).should_not be_nil
    details(sn).should == {:hybridFormula=>[{:genus=>{:epitheton=>"Arthopyrenia"}, :species=>{:epitheton=>"hyalospora"}}, "?"]}
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
  end
  
  it 'should parse names with taxon concept' do
    sn = "Sténométope laevissimus sec. Eschmeyer 2004"
    val = @parser.failure_reason.to_s.match(/column [0-9]*/).to_s().gsub(/column /,'')
    details(sn).should == {:genus=>{:epitheton=>"Sténométope"}, :species=>{:epitheton=>"laevissimus"}, :taxon_concept=>{:authorship=>"Eschmeyer 2004", :basionymAuthorTeam=>{:authorTeam=>"Eschmeyer", :author=>["Eschmeyer"], :year=>"2004"}}}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 29=>["author_word", 38], 39=>["year", 43]}
    sn = "Sténométope laevissimus Bibron 1855 sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == {:genus=>{:epitheton=>"Sténométope"}, :species=>{:epitheton=>"laevissimus", :authorship=>"Bibron 1855", :basionymAuthorTeam=>{:authorTeam=>"Bibron", :author=>["Bibron"], :year=>"1855"}}, :taxon_concept=>{:authorship=>"Eschmeyer 2004", :basionymAuthorTeam=>{:authorTeam=>"Eschmeyer", :author=>["Eschmeyer"], :year=>"2004"}}}
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 24=>["author_word", 30], 31=>["year", 35], 41=>["author_word", 50], 51=>["year", 55]}
  end
  
  it 'should parse names with spaces inconsistencies at the start and the end and in the middle' do
    parse("   Asplenium X inexpectatum (E.L. Braun 1940) Morton (1956)   ").should_not be_nil
  end
  
  it 'should not parse serveral authors groups with several years NOT CORRECT' do
    parse("Pseudocercospora dendrobii (H.C. Burnett 1883) (Leight.) (Movss. 1967) U. Braun & Crous 2003").should be_nil
  end

  it "should not parse unallowed utf-8 chars in name part" do
    parse("Érematosphaeria phaespora").should be_nil
    parse("Trematosphaeria phaeáapora").should be_nil
    parse("Trematоsphaeria phaeáapora").should be_nil #cyrillic o
  end

  
end