# encoding: UTF-8
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')


describe ScientificNameClean do
  before(:all) do
    set_parser(ScientificNameCleanParser.new)
  end
  
  it 'should parse uninomial' do
    sn = 'Pseudocercospora'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora'
    canonical(sn).should == 'Pseudocercospora'
    details(sn).should == [{:uninomial=>{:string=>"Pseudocercospora"}}]
    pos(sn).should == {0=>["uninomial", 16]}
  end
  
  it 'should parse uninomial with author and year' do
    sn = 'Pseudocercospora Speg.'
    parse(sn).should_not be_nil
    details(sn).should == [{:uninomial=>{:string=>"Pseudocercospora", :authorship=>"Speg.", :basionymAuthorTeam=>{:authorTeam=>"Speg.", :author=>["Speg."]}}}]
    pos(sn).should == {0=>["uninomial", 16], 17=>["author_word", 22]}    
    sn = 'Pseudocercospora Spegazzini, 1910'
    parse(sn).should_not be_nil
    value(sn).should == 'Pseudocercospora Spegazzini 1910'
    details(sn).should == [{:uninomial=>{:string=>"Pseudocercospora", :authorship=>"Spegazzini, 1910", :basionymAuthorTeam=>{:authorTeam=>"Spegazzini", :author=>["Spegazzini"], :year=>"1910"}}}]
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
    details(sn).should == [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii"}}]
    pos(sn).should == {0=>["genus", 16], 21=>["species", 30]}
  end
  
  
  it 'should parse species name with author and year' do
    sn = "Platypus bicaudatulus Schedl 1935"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    sn = "Platypus bicaudatulus Schedl, 1935h"
    parse(sn).should_not be_nil
    value(sn).should == "Platypus bicaudatulus Schedl 1935"
    details(sn).should == [{:genus=>{:string=>"Platypus"}, :species=>{:string=>"bicaudatulus", :authorship=>"Schedl, 1935h", :basionymAuthorTeam=>{:authorTeam=>"Schedl", :author=>["Schedl"], :year=>"1935"}}}]
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 22=>["author_word", 28], 30=>["year", 35]}
    parse("Platypus bicaudatulus Schedl, 1935B").should_not be_nil
    sn = "Platypus bicaudatulus Schedl (1935h)"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Platypus"}, :species=>{:string=>"bicaudatulus", :authorship=>"Schedl (1935h)", :basionymAuthorTeam=>{:authorTeam=>"Schedl", :author=>["Schedl"], :year=>"1935"}}}]
    parse("Platypus bicaudatulus Schedl 1935").should_not be_nil
  end
  
  it "should parse species name with author's postfix f., filius (son of)" do
    names = [ 
      [ "Platypus bicaudatulus Schedl f. 1935", [{:genus=>{:string=>"Platypus"}, :species=>{:string=>"bicaudatulus", :authorship=>"Schedl f. 1935", :basionymAuthorTeam=>{:authorTeam=>"Schedl f.", :author=>["Schedl f."], :year=>"1935"}}}], 'Platypus bicaudatulus Schedl f. 1935'],
      [ "Platypus bicaudatulus Schedl filius 1935", [{:genus=>{:string=>"Platypus"}, :species=>{:string=>"bicaudatulus", :authorship=>"Schedl filius 1935", :basionymAuthorTeam=>{:authorTeam=>"Schedl filius", :author=>["Schedl filius"], :year=>"1935"}}}], 'Platypus bicaudatulus Schedl filius 1935'],
      [ "Fimbristylis ovata (Burm. f.) J. Kern", [{:genus=>{:string=>"Fimbristylis"}, :species=>{:string=>"ovata", :authorship=>"(Burm. f.) J. Kern", :combinationAuthorTeam=>{:authorTeam=>"J. Kern", :author=>["J. Kern"]}, :basionymAuthorTeam=>{:authorTeam=>"Burm. f.", :author=>["Burm. f."]}}}], 'Fimbristylis ovata (Burm. f.) J. Kern'],
      [ "Carex chordorrhiza Ehrh. ex L. f.", [{:genus=>{:string=>"Carex"}, :species=>{:string=>"chordorrhiza", :authorship=>"Ehrh. ex L. f.", :basionymAuthorTeam=>{:authorTeam=>"Ehrh.", :author=>["Ehrh."], :exAuthorTeam=>{:authorTeam=>"L. f.", :author=>["L. f."]}}}}], 'Carex chordorrhiza Ehrh. ex L. f.'],
      [ "Amelanchier arborea var. arborea (Michx. f.) Fernald", [{:genus=>{:string=>"Amelanchier"}, :species=>{:string=>"arborea"}, :infraspecies=>[{:string=>"arborea", :rank=>"var.", :authorship=>"(Michx. f.) Fernald", :combinationAuthorTeam=>{:authorTeam=>"Fernald", :author=>["Fernald"]}, :basionymAuthorTeam=>{:authorTeam=>"Michx. f.", :author=>["Michx. f."]}}]}], 'Amelanchier arborea var. arborea (Michx. f.) Fernald'],
      [ "Cerastium arvense var. fuegianum Hook. f.", [{:genus=>{:string=>"Cerastium"}, :species=>{:string=>"arvense"}, :infraspecies=>[{:string=>"fuegianum", :rank=>"var.", :authorship=>"Hook. f.", :basionymAuthorTeam=>{:authorTeam=>"Hook. f.", :author=>["Hook. f."]}}]}], 'Cerastium arvense var. fuegianum Hook. f.'],
      [ "Cerastium arvense var. fuegianum Hook.f.", [{:genus=>{:string=>"Cerastium"}, :species=>{:string=>"arvense"}, :infraspecies=>[{:string=>"fuegianum", :rank=>"var.", :authorship=>"Hook.f.", :basionymAuthorTeam=>{:authorTeam=>"Hook.f.", :author=>["Hook.f."]}}]}], 'Cerastium arvense var. fuegianum Hook.f.'],
      [ "Cerastium arvense ssp. velutinum var. velutinum (Raf.) Britton f.", [{:genus=>{:string=>"Cerastium"}, :species=>{:string=>"arvense"}, :infraspecies=>[{:string=>"velutinum", :rank=>"ssp."}, {:string=>"velutinum", :rank=>"var.", :authorship=>"(Raf.) Britton f.", :combinationAuthorTeam=>{:authorTeam=>"Britton f.", :author=>["Britton f."]}, :basionymAuthorTeam=>{:authorTeam=>"Raf.", :author=>["Raf."]}}]}], "Cerastium arvense ssp. velutinum var. velutinum (Raf.) Britton f."],
      ["Amelanchier arborea f. hirsuta (Michx. f.) Fernald", [{:infraspecies=>[{:basionymAuthorTeam=>{:author=>["Michx. f."], :authorTeam=>"Michx. f."}, :string=>"hirsuta", :rank=>"f.", :combinationAuthorTeam=>{:author=>["Fernald"], :authorTeam=>"Fernald"}, :authorship=>"(Michx. f.) Fernald"}], :genus=>{:string=>"Amelanchier"}, :species=>{:string=>"arborea"}}], "Amelanchier arborea f. hirsuta (Michx. f.) Fernald"],
      ["Betula pendula fo. dalecarlica (L. f.) C.K. Schneid.", [{:infraspecies=>[{:basionymAuthorTeam=>{:author=>["L. f."], :authorTeam=>"L. f."}, :string=>"dalecarlica", :rank=>"f.", :combinationAuthorTeam=>{:author=>["C.K. Schneid."], :authorTeam=>"C.K. Schneid."}, :authorship=>"(L. f.) C.K. Schneid."}], :genus=>{:string=>"Betula"}, :species=>{:string=>"pendula"}}], "Betula pendula f. dalecarlica (L. f.) C.K. Schneid."],
      ["Racomitrium canescens f. ericoides (F. Weber ex Brid.) Mönk.", [{:genus=>{:string=>"Racomitrium"}, :species=>{:string=>"canescens"}, :infraspecies=>[{:string=>"ericoides", :rank=>"f.", :authorship=>"(F. Weber ex Brid.) Mönk.", :combinationAuthorTeam=>{:authorTeam=>"Mönk.", :author=>["Mönk."]}, :basionymAuthorTeam=>{:authorTeam=>"F. Weber", :author=>["F. Weber"], :exAuthorTeam=>{:authorTeam=>"Brid.", :author=>["Brid."]}}}]}], "Racomitrium canescens f. ericoides (F. Weber ex Brid.) Mönk."],
      ["Racomitrium canescens forma ericoides (F. Weber ex Brid.) Mönk.", [{:genus=>{:string=>"Racomitrium"}, :species=>{:string=>"canescens"}, :infraspecies=>[{:string=>"ericoides", :rank=>"f.", :authorship=>"(F. Weber ex Brid.) Mönk.", :combinationAuthorTeam=>{:authorTeam=>"Mönk.", :author=>["Mönk."]}, :basionymAuthorTeam=>{:authorTeam=>"F. Weber", :author=>["F. Weber"], :exAuthorTeam=>{:authorTeam=>"Brid.", :author=>["Brid."]}}}]}], "Racomitrium canescens f. ericoides (F. Weber ex Brid.) Mönk."],
    ]
    names.each do |sn, sn_details, sn_value|  
      parse(sn).should_not be_nil
      details(sn).should == sn_details
      value(sn).should == sn_value
    end
  end
  
  it 'should parse genus with "?"' do
    sn = "Ferganoconcha? oblonga"
    parse(sn).should_not be_nil
    value(sn).should == "Ferganoconcha oblonga"
    details(sn).should == [{:genus=>{:string=>"Ferganoconcha"}, :species=>{:string=>"oblonga"}}]
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
      ['Œnanthæ œnanthe','Oenanthae oenanthe'],
      ['Œnanthe œnanthe','Oenanthe oenanthe'],
      ['Cerambyx thomæ Gmelin J. F., 1790', 'Cerambyx thomae Gmelin J. F. 1790']
    ]
    names.each do |name_pair|
      parse(name_pair[0]).should_not be_nil
      value(name_pair[0]).should == name_pair[1]
    end
  end
  
  it 'should parse names with e-umlaut' do
   sn = 'Kalanchoë tuberosa'
   canonical(sn).should == 'Kalanchoë tuberosa'
   sn = 'Isoëtes asplundii H. P. Fuchs'
   canonical(sn).should == 'Isoëtes asplundii'
  end

  it 'should parse infragenus (ICZN code)' do
    sn = "Hegeter (Hegeter) intercedens Lindberg H 1950"
    parse(sn).should_not be_nil
    value(sn).should == "Hegeter (Hegeter) intercedens Lindberg H 1950"
    canonical(sn).should == "Hegeter intercedens"
    details(sn).should == [{:genus=>{:string=>"Hegeter"}, :infragenus=>{:string=>"Hegeter"}, :species=>{:string=>"intercedens", :authorship=>"Lindberg H 1950", :basionymAuthorTeam=>{:authorTeam=>"Lindberg H", :author=>["Lindberg H"], :year=>"1950"}}}]
    pos(sn).should == {0=>["genus", 7], 9=>["infragenus", 16], 18=>["species", 29], 30=>["author_word", 38], 39=>["author_word", 40], 41=>["year", 45]}
    sn = "Ixodes (Ixodes) hexagonus hexagonus Neumann, 1911"
    canonical(sn).should == "Ixodes hexagonus hexagonus"
    sn = "Brachytrypus (B.) grandidieri" 
    canonical(sn).should == "Brachytrypus grandidieri"
    details(sn).should == [{:genus=>{:string=>"Brachytrypus"}, :infragenus=>{:string=>"B."}, :species=>{:string=>"grandidieri"}}]
    sn = "Empis (Argyrandrus) Bezzi 1909"
    details(sn).should == [{:uninomial=>{:string=>"Empis", :infragenus=>{:string=>"Argyrandrus"}, :authorship=>"Bezzi 1909", :basionymAuthorTeam=>{:authorTeam=>"Bezzi", :author=>["Bezzi"], :year=>"1909"}}}]
    sn = "Platydoris (Bergh )"
    details(sn).should == [{:uninomial=>{:string=>"Platydoris", :infragenus=>{:string=>"Bergh"}}}]
    value(sn).should == "Platydoris (Bergh)"
    sn = "Platydoris (B.)"
    details(sn).should == [{:uninomial=>{:string=>"Platydoris", :infragenus=>{:string=>"B."}}}]
  end
  
  it 'should parse several authors without a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should ==  [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii", :authorship=>"U. Braun & Crous", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"]}}}]
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
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora", :authorship=>"(Nyl.)R.C.     Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C.     Harris", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."]}}}]
  end
  
  it 'should parse several authors with a year' do
    sn = "Pseudocercospora dendrobii U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii", :authorship=>"U. Braun & Crous 2003", :basionymAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}}}]
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 27=>["author_word", 29], 30=>["author_word", 35], 38=>["author_word", 43], 44=>["year", 48]}
    sn = "Pseudocercospora dendrobii Crous, 2003"
    parse(sn).should_not be_nil
  end
  
  it 'should parse basionym authors in parenthesis' do
    sn = "Zophosis persis (Chatanay, 1914)"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Zophosis"}, :species=>{:string=>"persis", :authorship=>"(Chatanay, 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}]
    sn = "Zophosis persis (Chatanay 1914)"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Zophosis"}, :species=>{:string=>"persis", :authorship=>"(Chatanay 1914)", :basionymAuthorTeam=>{:authorTeam=>"Chatanay", :author=>["Chatanay"], :year=>"1914"}}}]
    sn = "Zophosis persis (Chatanay), 1914"
    parse(sn).should_not be_nil
    value(sn).should == "Zophosis persis (Chatanay 1914)"
    details(sn).should == [{:genus=>{:string=>"Zophosis"}, :species=>{:string=>"persis", :authorship=>"(Chatanay), 1914", :basionymAuthorTeam=>{:author_team=>"(Chatanay), 1914", :author=>["Chatanay"], :year=>"1914"}}}]
    pos(sn).should == {0=>["genus", 8], 9=>["species", 15], 17=>["author_word", 25], 28=>["year", 32]}
    parse("Zophosis persis (Chatanay) 1914").should_not be_nil
    #parse("Zophosis persis Chatanay (1914)").should_not be_nil
  end  
  
  it 'should parse scientific name' do
    sn = "Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii", :authorship=>"(H.C.     Burnett)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"]}}}]
    sn = "Pseudocercospora dendrobii(H.C.     Burnett,1873)U. Braun & Crous     2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1873) U. Braun et Crous 2003"
    details(sn).should == [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii", :authorship=>"(H.C.     Burnett,1873)U. Braun & Crous     2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C.     Burnett", :author=>["H.C. Burnett"], :year=>"1873"}}}]
  end
  
  it 'should parse several authors with several years' do
    sn = "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003"
    parse(sn).should_not be_nil
    value(sn).should == "Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun et Crous 2003"
    canonical(sn).should == "Pseudocercospora dendrobii"
    details(sn).should == [{:genus=>{:string=>"Pseudocercospora"}, :species=>{:string=>"dendrobii", :authorship=>"(H.C. Burnett 1883) U. Braun & Crous 2003", :combinationAuthorTeam=>{:authorTeam=>"U. Braun & Crous", :author=>["U. Braun", "Crous"], :year=>"2003"}, :basionymAuthorTeam=>{:authorTeam=>"H.C. Burnett", :author=>["H.C. Burnett"], :year=>"1883"}}}]
    pos(sn).should == {0=>["genus", 16], 17=>["species", 26], 28=>["author_word", 32], 33=>["author_word", 40], 41=>["year", 45], 47=>["author_word", 49], 50=>["author_word", 55], 58=>["author_word", 63], 64=>["year", 68]}
  end

  it "should parse name with subspecies without rank Zoological Code" do
    sn = "Hydnellum scrobiculatum zonatum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum zonatum (Banker) D. Hall et D.E. Stuntz 1972"
    canonical(sn).should == "Hydnellum scrobiculatum zonatum"
    details(sn).should == [{:genus=>{:string=>"Hydnellum"}, :species=>{:string=>"scrobiculatum"}, :infraspecies=>[{:string=>"zonatum", :rank=>"n/a", :authorship=>"(Banker) D. Hall & D.E. Stuntz 1972", :combinationAuthorTeam=>{:authorTeam=>"D. Hall & D.E. Stuntz", :author=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :basionymAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}]}]
    pos(sn).should == {0=>["genus", 9], 10=>["species", 23], 24=>["infraspecies", 31], 33=>["author_word", 39], 41=>["author_word", 43], 44=>["author_word", 48], 51=>["author_word", 55], 56=>["author_word", 62], 63=>["year", 67]}
    sn = "Begonia pingbienensis angustior"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Begonia"}, :species=>{:string=>"pingbienensis"}, :infraspecies=>[{:string=>"angustior", :rank=>"n/a"}]}]
    pos(sn).should == {0=>["genus", 7], 8=>["species", 21], 22=>["infraspecies", 31]}
  end

  it 'should parse infraspecies with rank' do
    sn = "Aus bus Linn. var. bus"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Aus"}, :species=>{:string=>"bus", :authorship=>"Linn.", :basionymAuthorTeam=>{:authorTeam=>"Linn.", :author=>["Linn."]}}, :infraspecies=>[{:string=>"bus", :rank=>"var."}]}]
    sn = "Agalinis purpurea (L.) Briton var. borealis (Berg.) Peterson 1987"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Agalinis"}, :species=>{:string=>"purpurea", :authorship=>"(L.) Briton", :combinationAuthorTeam=>{:authorTeam=>"Briton", :author=>["Briton"]}, :basionymAuthorTeam=>{:authorTeam=>"L.", :author=>["L."]}}, :infraspecies=>[{:string=>"borealis", :rank=>"var.", :authorship=>"(Berg.) Peterson 1987", :combinationAuthorTeam=>{:authorTeam=>"Peterson", :author=>["Peterson"], :year=>"1987"}, :basionymAuthorTeam=>{:authorTeam=>"Berg.", :author=>["Berg."]}}]}]
    pos(sn).should == {0=>["genus", 8], 9=>["species", 17], 19=>["author_word", 21], 23=>["author_word", 29], 35=>["infraspecies", 43], 45=>["author_word", 50], 52=>["author_word", 60], 61=>["year", 65]}
    sn = "Phaeographis inusta var. macularis(Leight.) A.L. Sm. 1861"
    parse(sn).should_not be_nil
    value(sn).should == "Phaeographis inusta var. macularis (Leight.) A.L. Sm. 1861"
    canonical(sn).should == "Phaeographis inusta macularis"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 19], 25=>["infraspecies", 34], 35=>["author_word", 42], 44=>["author_word", 48], 49=>["author_word", 52], 53=>["year", 57]}
    sn = "Cassytha peninsularis J. Z. Weber var. flindersii"
    canonical(sn).should == "Cassytha peninsularis flindersii"
  end

  it 'should parse unknown original authors (auct.)/(hort.)/(?)' do
    sn = "Tragacantha leporina (?) Kuntze"
    parse(sn).should_not be_nil
    value(sn).should == "Tragacantha leporina (?) Kuntze"
    details(sn).should == [{:genus=>{:string=>"Tragacantha"}, :species=>{:string=>"leporina", :authorship=>"(?) Kuntze", :combinationAuthorTeam=>{:authorTeam=>"Kuntze", :author=>["Kuntze"]}, :basionymAuthorTeam=>{:authorTeam=>"(?)", :author=>["?"]}}}]
    sn = "Lachenalia tricolor var. nelsonii (auct.) Baker"
    parse(sn).should_not be_nil
    value(sn).should == "Lachenalia tricolor var. nelsonii (auct.) Baker"
    details(sn).should == [{:genus=>{:string=>"Lachenalia"}, :species=>{:string=>"tricolor"}, :infraspecies=>[{:string=>"nelsonii", :rank=>"var.", :authorship=>"(auct.) Baker", :combinationAuthorTeam=>{:authorTeam=>"Baker", :author=>["Baker"]}, :basionymAuthorTeam=>{:authorTeam=>"auct.", :author=>["unknown"]}}]}]
    pos(sn).should == {0=>["genus", 10], 11=>["species", 19], 25=>["infraspecies", 33], 35=>["unknown_author", 40], 42=>["author_word", 47]}
  end  
  
  it 'should parse unknown authors auct./anon./hort./ht.' do
    sn = "Puya acris ht."
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 4], 5=>["species", 10], 11=>["unknown_author", 14]}
  end
  
  it 'should parse real world examples' do
    sn = "Stagonospora polyspora M.T. Lucas & Sousa da Câmara 1934"
    parse(sn).should_not be_nil
    value(sn).should == "Stagonospora polyspora M.T. Lucas et Sousa da Câmara 1934"
    details(sn).should == [{:genus=>{:string=>"Stagonospora"}, :species=>{:string=>"polyspora", :authorship=>"M.T. Lucas & Sousa da Câmara 1934", :basionymAuthorTeam=>{:authorTeam=>"M.T. Lucas & Sousa da Câmara", :author=>["M.T. Lucas", "Sousa da Câmara"], :year=>"1934"}}}]
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
    details(sn).should == [{:genus=>{:string=>"Tuber"}, :species=>{:string=>"liui", :authorship=>"A S. Xu 1999", :basionymAuthorTeam=>{:authorTeam=>"A S. Xu", :author=>["A S. Xu"], :year=>"1999"}}}]
    parse('Xylaria potentillae A S. Xu').should_not be_nil
    parse("Agaricus squamula Berk. & M.A. Curtis 1860").should_not be_nil
    parse("Peltula coriacea Büdel, Henssen & Wessels 1986").should_not be_nil
    #had to add no dot rule for trinomials without a rank to make it to work
    sn = "Saccharomyces drosophilae anon."
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Saccharomyces"}, :species=>{:string=>"drosophilae", :authorship=>"anon.", :basionymAuthorTeam=>{:authorTeam=>"anon.", :author=>["unknown"]}}}]
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
    details(sn).should == [{:genus=>{:string=>"Cypraeovula"}, :infragenus=>{:string=>"Luponia"}, :species=>{:string=>"amphithales"}, :infraspecies=>[{:string=>"perdentata", :rank=>"n/a"}]}]
    sn = "Polyrhachis orsyllus nat musculus Forel 1901"
    canonical(sn).should == "Polyrhachis orsyllus musculus"
    sn = 'Latrodectus 13-guttatus Thorell, 1875'
    canonical(sn).should == 'Latrodectus tredecguttatus'
    value(sn).should == 'Latrodectus tredecguttatus Thorell 1875'
    sn = 'Latrodectus 3-guttatus Thorell, 1875'
    canonical(sn).should == 'Latrodectus triguttatus'
    value(sn).should == 'Latrodectus triguttatus Thorell 1875'
    sn = 'Balaninus c-album Schönherr, CJ., 1836'
    canonical(sn).should == 'Balaninus c-album'
  end

  it "should parse name with morph." do
    sn = "Callideriphus flavicollis morph. reductus Fuchs 1961"
    parse(sn).should_not be_nil
    value(sn).should == "Callideriphus flavicollis morph. reductus Fuchs 1961"
    canonical(sn).should == "Callideriphus flavicollis reductus"
    details(sn).should == [{:genus=>{:string=>"Callideriphus"}, :species=>{:string=>"flavicollis"}, :infraspecies=>[{:string=>"reductus", :rank=>"morph.", :authorship=>"Fuchs 1961", :basionymAuthorTeam=>{:authorTeam=>"Fuchs", :author=>["Fuchs"], :year=>"1961"}}]}]
    pos(sn).should == {0=>["genus", 13], 14=>["species", 25], 33=>["infraspecies", 41], 42=>["author_word", 47], 48=>["year", 52]}
  end

  
  it "should parse name with forma/fo./form./f." do
    sn = "Caulerpa cupressoides forma nuda"
    parse(sn).should_not be_nil
    value(sn).should == "Caulerpa cupressoides f. nuda"
    canonical(sn).should == "Caulerpa cupressoides nuda"
    details(sn).should == [{:genus=>{:string=>"Caulerpa"}, :species=>{:string=>"cupressoides"}, :infraspecies=>[{:string=>"nuda", :rank=>"f."}]}]
    pos(sn).should == {0=>["genus", 8], 9=>["species", 21], 28=>["infraspecies", 32]}
    sn = "Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó"
    parse(sn).should_not be_nil
    value("Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó").should == "Chlorocyperus glaber f. fasciculariforme (Lojac.) Soó"
    canonical(sn).should == "Chlorocyperus glaber fasciculariforme"
    details(sn).should == [{:genus=>{:string=>"Chlorocyperus"}, :species=>{:string=>"glaber"}, :infraspecies=>[{:string=>"fasciculariforme", :rank=>"f.", :authorship=>"(Lojac.) Soó", :combinationAuthorTeam=>{:authorTeam=>"Soó", :author=>["Soó"]}, :basionymAuthorTeam=>{:authorTeam=>"Lojac.", :author=>["Lojac."]}}]}]
    pos(sn).should == {0=>["genus", 13], 14=>["species", 20], 27=>["infraspecies", 43], 45=>["author_word", 51], 53=>["author_word", 56]}
    sn = "Bambusa nana Roxb. fo. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    parse(sn).should_not be_nil
    value(sn).should == "Bambusa nana Roxb. f. alphonse-karri (Mitford ex Satow) Makino ex Shiros."
    canonical(sn).should == "Bambusa nana alphonse-karri"
    details(sn).should == [{:genus=>{:string=>"Bambusa"}, :species=>{:string=>"nana", :authorship=>"Roxb.", :basionymAuthorTeam=>{:authorTeam=>"Roxb.", :author=>["Roxb."]}}, :infraspecies=>[{:string=>"alphonse-karri", :rank=>"f.", :authorship=>"(Mitford ex Satow) Makino ex Shiros.", :combinationAuthorTeam=>{:authorTeam=>"Makino", :author=>["Makino"], :exAuthorTeam=>{:authorTeam=>"Shiros.", :author=>["Shiros."]}}, :basionymAuthorTeam=>{:authorTeam=>"Mitford", :author=>["Mitford"], :exAuthorTeam=>{:authorTeam=>"Satow", :author=>["Satow"]}}}]}]
    pos(sn).should ==  {0=>["genus", 7], 8=>["species", 12], 13=>["author_word", 18], 23=>["infraspecies", 37], 39=>["author_word", 46], 50=>["author_word", 55], 57=>["author_word", 63], 67=>["author_word", 74]}
    sn = "   Sphaerotheca    fuliginea     f.    dahliae    Movss.   1967    "
    sn = "Sphaerotheca    fuliginea    f.     dahliae    Movss.     1967"
    parse(sn).should_not be_nil
    value(sn).should == "Sphaerotheca fuliginea f. dahliae Movss. 1967"
    canonical(sn).should == "Sphaerotheca fuliginea dahliae"
    details(sn).should ==  [{:genus=>{:string=>"Sphaerotheca"}, :species=>{:string=>"fuliginea"}, :infraspecies=>[{:string=>"dahliae", :rank=>"f.", :authorship=>"Movss.     1967", :basionymAuthorTeam=>{:authorTeam=>"Movss.", :author=>["Movss."], :year=>"1967"}}]}]
    pos(sn).should == {0=>["genus", 12], 16=>["species", 25], 36=>["infraspecies", 43], 47=>["author_word", 53], 58=>["year", 62]}
    parse('Polypodium vulgare nothosubsp. mantoniae (Rothm.) Schidlay').should_not be_nil
  end
  
  it "should parse name with several subspecies names NOT BOTANICAL CODE BUT NOT INFREQUENT" do
    sn = "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall & D.E. Stuntz 1972"
    parse(sn).should_not be_nil
    value(sn).should == "Hydnellum scrobiculatum var. zonatum f. parvum (Banker) D. Hall et D.E. Stuntz 1972"
    details(sn).should ==  [{:genus=>{:string=>"Hydnellum"}, :species=>{:string=>"scrobiculatum"}, :infraspecies=>[{:string=>"zonatum", :rank=>"var."}, {:string=>"parvum", :rank=>"f.", :authorship=>"(Banker) D. Hall & D.E. Stuntz 1972", :combinationAuthorTeam=>{:authorTeam=>"D. Hall & D.E. Stuntz", :author=>["D. Hall", "D.E. Stuntz"], :year=>"1972"}, :basionymAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}]}]
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
    details(sn).should ==  [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora", :authorship=>"(Nyl.) R.C. Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C. Harris", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."]}}, :status=>"comb. nov."}]
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 31=>["author_word", 35], 36=>["author_word", 42]}
  end
  
  it "should parse revised (ex) names" do
    #invalidly published
    sn = "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    parse(sn).should_not be_nil
    value(sn).should == "Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris"
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora", :authorship=>"(Nyl. ex Banker) R.C. Harris", :combinationAuthorTeam=>{:authorTeam=>"R.C. Harris", :author=>["R.C. Harris"]}, :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."], :exAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}}]
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 29], 33=>["author_word", 39], 41=>["author_word", 45], 46=>["author_word", 52]}
    sn = "Arthopyrenia hyalospora Nyl. ex Banker"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora", :authorship=>"Nyl. ex Banker", :basionymAuthorTeam=>{:authorTeam=>"Nyl.", :author=>["Nyl."], :exAuthorTeam=>{:authorTeam=>"Banker", :author=>["Banker"]}}}}]
    sn = "Glomopsis lonicerae Peck ex C.J. Gould 1945"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Glomopsis"}, :species=>{:string=>"lonicerae", :authorship=>"Peck ex C.J. Gould 1945", :basionymAuthorTeam=>{:authorTeam=>"Peck", :author=>["Peck"], :exAuthorTeam=>{:authorTeam=>"C.J. Gould", :author=>["C.J. Gould"], :year=>"1945"}}}}]
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 20=>["author_word", 24], 28=>["author_word", 32], 33=>["author_word", 38], 39=>["year", 43]}
    parse("Acanthobasidium delicatum (Wakef.) Oberw. ex Jülich 1979").should_not be_nil
    sn = "Mycosphaerella eryngii (Fr. ex Duby) Johanson ex Oudem. 1897"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Mycosphaerella"}, :species=>{:string=>"eryngii", :authorship=>"(Fr. ex Duby) Johanson ex Oudem. 1897", :combinationAuthorTeam=>{:authorTeam=>"Johanson", :author=>["Johanson"], :exAuthorTeam=>{:authorTeam=>"Oudem.", :author=>["Oudem."], :year=>"1897"}}, :basionymAuthorTeam=>{:authorTeam=>"Fr.", :author=>["Fr."], :exAuthorTeam=>{:authorTeam=>"Duby", :author=>["Duby"]}}}}]
    pos(sn).should == {0=>["genus", 14], 15=>["species", 22], 24=>["author_word", 27], 31=>["author_word", 35], 37=>["author_word", 45], 49=>["author_word", 55], 56=>["year", 60]}
    #invalid but happens
    parse("Mycosphaerella eryngii (Fr. Duby) ex Oudem. 1897").should_not be_nil
    parse("Mycosphaerella eryngii (Fr.ex Duby) ex Oudem. 1897").should_not be_nil
    sn = "Salmonella werahensis (Castellani) Hauduroy and Ehringer in Hauduroy 1937"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Salmonella"}, :species=>{:string=>"werahensis", :authorship=>"(Castellani) Hauduroy and Ehringer in Hauduroy 1937", :combinationAuthorTeam=>{:authorTeam=>"Hauduroy and Ehringer", :author=>["Hauduroy", "Ehringer"], :exAuthorTeam=>{:authorTeam=>"Hauduroy", :author=>["Hauduroy"], :year=>"1937"}}, :basionymAuthorTeam=>{:authorTeam=>"Castellani", :author=>["Castellani"]}}}]
    pos(sn).should == {0=>["genus", 10], 11=>["species", 21], 23=>["author_word", 33], 35=>["author_word", 43], 48=>["author_word", 56], 60=>["author_word", 68], 69=>["year", 73]}
  end
    
  it 'should parse named hybrids' do
    [
      ["×Agropogon P. Fourn. 1934", [{:uninomial=>{:string=>"Agropogon", :authorship=>"P. Fourn. 1934", :basionymAuthorTeam=>{:authorTeam=>"P. Fourn.", :author=>["P. Fourn."], :year=>"1934"}}}]],
      ["xAgropogon P. Fourn.", [{:uninomial=>{:string=>"Agropogon", :authorship=>"P. Fourn.", :basionymAuthorTeam=>{:authorTeam=>"P. Fourn.", :author=>["P. Fourn."]}}}]],
      ["XAgropogon P.Fourn.", [{:uninomial=>{:string=>"Agropogon", :authorship=>"P.Fourn.", :basionymAuthorTeam=>{:authorTeam=>"P.Fourn.", :author=>["P.Fourn."]}}}]],
      ["× Agropogon", [{:uninomial=>{:string=>"Agropogon"}}]],
      ["x Agropogon", [{:uninomial=>{:string=>"Agropogon"}}]],
      ["X Agropogon", [{:uninomial=>{:string=>"Agropogon"}}]],
      ["X Cupressocyparis leylandii", [{:genus=>{:string=>"Cupressocyparis"}, :species=>{:string=>"leylandii"}}]],
      ["×Heucherella tiarelloides", [{:genus=>{:string=>"Heucherella"}, :species=>{:string=>"tiarelloides"}}]],
      ["xHeucherella tiarelloides", [{:genus=>{:string=>"Heucherella"}, :species=>{:string=>"tiarelloides"}}]],
      ["x Heucherella tiarelloides", [{:genus=>{:string=>"Heucherella"}, :species=>{:string=>"tiarelloides"}}]],
      ["×Agropogon littoralis (Sm.) C. E. Hubb. 1946", [{:genus=>{:string=>"Agropogon"}, :species=>{:string=>"littoralis", :authorship=>"(Sm.) C. E. Hubb. 1946", :combinationAuthorTeam=>{:authorTeam=>"C. E. Hubb.", :author=>["C. E. Hubb."], :year=>"1946"}, :basionymAuthorTeam=>{:authorTeam=>"Sm.", :author=>["Sm."]}}}]]
    ].each do |res| 
      parse(res[0]).should_not be_nil
      parse(res[0]).hybrid.should be_true
      details(res[0]).should == res[1]
    end
   [ 
    ['Asplenium X inexpectatum (E.L. Braun 1940) Morton (1956)',[{:genus=>{:string=>"Asplenium"}, :species=>{:string=>"inexpectatum", :authorship=>"(E.L. Braun 1940) Morton (1956)", :combinationAuthorTeam=>{:authorTeam=>"Morton", :author=>["Morton"], :year=>"1956"}, :basionymAuthorTeam=>{:authorTeam=>"E.L. Braun", :author=>["E.L. Braun"], :year=>"1940"}}}]],
    ['Mentha ×smithiana R. A. Graham 1949',[{:genus=>{:string=>"Mentha"}, :species=>{:string=>"smithiana", :authorship=>"R. A. Graham 1949", :basionymAuthorTeam=>{:authorTeam=>"R. A. Graham", :author=>["R. A. Graham"], :year=>"1949"}}}]],
    ['Salix ×capreola Andersson (1867)',[{:genus=>{:string=>"Salix"}, :species=>{:string=>"capreola", :authorship=>"Andersson (1867)", :basionymAuthorTeam=>{:authorTeam=>"Andersson", :author=>["Andersson"], :year=>"1867"}}}]],
    ['Salix x capreola Andersson',[{:genus=>{:string=>"Salix"}, :species=>{:string=>"capreola", :authorship=>"Andersson", :basionymAuthorTeam=>{:authorTeam=>"Andersson", :author=>["Andersson"]}}}]]
   ].each do |res|
      parse(res[0]).should_not be_nil
      parse(res[0]).hybrid.should be_true
      details(res[0]).should == res[1]
   end
   sn = "Rosa alpina x pomifera"
   canonical(sn).should == "Rosa alpina × pomifera"
   parse(sn).details.should == [{:genus=>{:string=>"Rosa"}, :species=>{:string=>"alpina"}}, {:species=>{:string=>"pomifera"}, :genus=>{:string=>"Rosa"}}]
  end
  
  it "should parse hybrid combination" do
    sn = "Arthopyrenia hyalospora X Hydnellum scrobiculatum"
    parse(sn).should_not be_nil
    parse(sn).hybrid.should be_true
    value(sn).should == "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    canonical(sn).should == "Arthopyrenia hyalospora × Hydnellum scrobiculatum"
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora"}}, {:genus=>{:string=>"Hydnellum"}, :species=>{:string=>"scrobiculatum"}}]
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 26=>["genus", 35], 36=>["species", 49]}
    sn = "Arthopyrenia hyalospora (Banker) D. Hall X Hydnellum scrobiculatum D.E. Stuntz"
    parse(sn).should_not be_nil
    parse(sn).hybrid.should be_true
    value(sn).should == "Arthopyrenia hyalospora (Banker) D. Hall \303\227 Hydnellum scrobiculatum D.E. Stuntz"
    canonical(sn).should == "Arthopyrenia hyalospora × Hydnellum scrobiculatum"
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23], 25=>["author_word", 31], 33=>["author_word", 35], 36=>["author_word", 40], 43=>["genus", 52], 53=>["species", 66], 67=>["author_word", 71], 72=>["author_word", 78]}
    value("Arthopyrenia hyalospora X").should == "Arthopyrenia hyalospora \303\227 ?"  
    sn = "Arthopyrenia hyalospora x"
    parse(sn).should_not be_nil
    parse(sn).hybrid.should be_true
    canonical(sn).should == "Arthopyrenia hyalospora"
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora"}}, "?"]
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
    sn = "Arthopyrenia hyalospora × ?"
    parse(sn).should_not be_nil
    parse(sn).hybrid.should be_true
    details(sn).should == [{:genus=>{:string=>"Arthopyrenia"}, :species=>{:string=>"hyalospora"}}, "?"]
    pos(sn).should == {0=>["genus", 12], 13=>["species", 23]}
  end
  
  it 'should parse names with taxon concept' do
    sn = "Stenometope laevissimus sec. Eschmeyer 2004"
    details(sn).should == [{:genus=>{:string=>"Stenometope"}, :species=>{:string=>"laevissimus"}, :taxon_concept=>{:authorship=>"Eschmeyer 2004", :basionymAuthorTeam=>{:authorTeam=>"Eschmeyer", :author=>["Eschmeyer"], :year=>"2004"}}}]
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 29=>["author_word", 38], 39=>["year", 43]}
    sn = "Stenometope laevissimus Bibron 1855 sec. Eschmeyer 2004"
    parse(sn).should_not be_nil
    details(sn).should == [{:genus=>{:string=>"Stenometope"}, :species=>{:string=>"laevissimus", :authorship=>"Bibron 1855", :basionymAuthorTeam=>{:authorTeam=>"Bibron", :author=>["Bibron"], :year=>"1855"}}, :taxon_concept=>{:authorship=>"Eschmeyer 2004", :basionymAuthorTeam=>{:authorTeam=>"Eschmeyer", :author=>["Eschmeyer"], :year=>"2004"}}}]
    pos(sn).should == {0=>["genus", 11], 12=>["species", 23], 24=>["author_word", 30], 31=>["year", 35], 41=>["author_word", 50], 51=>["year", 55]}
  end
  
  it 'should parse names with spaces inconsistencies at the start and the end and in the middle' do
    parse("   Asplenium X inexpectatum (E.L. Braun 1940) Morton (1956)   ").should_not be_nil
  end
  
  it 'should parse names with any number of spaces' do 
    sn = "Trematosphaeria phaeospora (E. Müll.)         L.             Holm 1957"
    parse(sn).should_not be_nil
    value(sn).should == "Trematosphaeria phaeospora (E. Müll.) L. Holm 1957"
    canonical(sn).should == "Trematosphaeria phaeospora"
    details(sn).should == [{:genus=>{:string=>"Trematosphaeria"}, :species=>{:string=>"phaeospora", :authorship=>"(E. Müll.)         L.             Holm 1957", :combinationAuthorTeam=>{:authorTeam=>"L.             Holm", :author=>["L. Holm"], :year=>"1957"}, :basionymAuthorTeam=>{:authorTeam=>"E. Müll.", :author=>["E. Müll."]}}}]
    pos(sn).should == {0=>["genus", 15], 16=>["species", 26], 28=>["author_word", 30], 31=>["author_word", 36], 46=>["author_word", 48], 61=>["author_word", 65], 66=>["year", 70]}
  end
  
  it 'should not parse serveral authors groups with several years NOT CORRECT' do
    parse("Pseudocercospora dendrobii (H.C. Burnett 1883) (Leight.) (Movss. 1967) U. Braun & Crous 2003").should be_nil
  end

  it "should not parse unallowed utf-8 chars in name part" do
    parse("Érematosphaeria phaespora").should be_nil
    parse("Trematosphaeria phaeáapora").should be_nil
    parse("Trematоsphaeria phaeaapora").should be_nil #cyrillic o
  end

  it "should parse new stuff" do
    sn = 'Nesticus quelpartensis Paik & Namkung, in Paik, Yaginuma & Namkung, 1969'
    details(sn).should == [{:genus=>{:string=>"Nesticus"}, :species=>{:string=>"quelpartensis", :authorship=>"Paik & Namkung, in Paik, Yaginuma & Namkung, 1969", :basionymAuthorTeam=>{:authorTeam=>"Paik & Namkung", :author=>["Paik", "Namkung"], :exAuthorTeam=>{:authorTeam=>"Paik, Yaginuma & Namkung", :author=>["Paik", "Yaginuma", "Namkung"], :year=>"1969"}}}}]
    parse('Dipoena yoshidai Ono, in Ono et al., 1991').should_not be_nil
    sn = 'Latrodectus mactans bishopi Kaston, 1938'
    details(sn).should == [{:genus=>{:string=>"Latrodectus"}, :species=>{:string=>"mactans"}, :infraspecies=>[{:string=>"bishopi", :rank=>"n/a", :authorship=>"Kaston, 1938", :basionymAuthorTeam=>{:authorTeam=>"Kaston", :author=>["Kaston"], :year=>"1938"}}]}]
    sn = 'Diplocephalus aff. procerus Thaler, 1972'
    details(sn).should == [{:genus=>{:string=>"Diplocephalus"}, :species=>{:string=>"procerus", :authorship=>"Thaler, 1972", :basionymAuthorTeam=>{:authorTeam=>"Thaler", :author=>["Thaler"], :year=>"1972"}}}]
    sn = 'Thiobacillus x Parker and Prisk 1953' #have to figure out black lists for this one
    sn = 'Bacille de Plaut, Kritchevsky and Séguin 1921'
    details(sn).should == [{:uninomial=>{:string=>"Bacille", :authorship=>"de Plaut, Kritchevsky and Séguin 1921", :basionymAuthorTeam=>{:authorTeam=>"de Plaut, Kritchevsky and Séguin", :author=>["de Plaut", "Kritchevsky", "Séguin"], :year=>"1921"}}}]
    sn = 'Araneus van bruysseli Petrunkevitch, 1911'
    details(sn).should == [{:genus=>{:string=>"Araneus"}, :species=>{:string=>"van"}, :infraspecies=>[{:string=>"bruysseli", :rank=>"n/a", :authorship=>"Petrunkevitch, 1911", :basionymAuthorTeam=>{:authorTeam=>"Petrunkevitch", :author=>["Petrunkevitch"], :year=>"1911"}}]}]
    sn = 'Sapromyces laidlawi ab Sabin 1941'
    details(sn).should == [{:genus=>{:string=>"Sapromyces"}, :species=>{:string=>"laidlawi", :authorship=>"ab Sabin 1941", :basionymAuthorTeam=>{:authorTeam=>"ab Sabin", :author=>["ab Sabin"], :year=>"1941"}}}]
    sn = 'Nocardia rugosa di Marco and Spalla 1957'
    details(sn).should == [{:genus=>{:string=>"Nocardia"}, :species=>{:string=>"rugosa", :authorship=>"di Marco and Spalla 1957", :basionymAuthorTeam=>{:authorTeam=>"di Marco and Spalla", :author=>["di Marco", "Spalla"], :year=>"1957"}}}]
    sn = 'Flexibacter elegans Lewin 1969 non Soriano 1945'
    details(sn).should == [{:genus=>{:string=>"Flexibacter"}, :species=>{:string=>"elegans", :authorship=>"Lewin 1969 non Soriano 1945", :basionymAuthorTeam=>{:authorTeam=>"Lewin", :author=>["Lewin"], :year=>"1969"}}}]
    sn = 'Flexibacter elegans Soriano 1945, non Lewin 1969'
    details(sn).should == [{:genus=>{:string=>"Flexibacter"}, :species=>{:string=>"elegans", :authorship=>"Soriano 1945, non Lewin 1969", :basionymAuthorTeam=>{:authorTeam=>"Soriano", :author=>["Soriano"], :year=>"1945"}}}]
    sn = 'Schottera nicaeënsis (J.V. Lamouroux ex Duby) Guiry & Hollenberg'
    details(sn).should == [{:genus=>{:string=>"Schottera"}, :species=>{:string=>"nicaeënsis", :authorship=>"(J.V. Lamouroux ex Duby) Guiry & Hollenberg", :combinationAuthorTeam=>{:authorTeam=>"Guiry & Hollenberg", :author=>["Guiry", "Hollenberg"]}, :basionymAuthorTeam=>{:authorTeam=>"J.V. Lamouroux", :author=>["J.V. Lamouroux"], :exAuthorTeam=>{:authorTeam=>"Duby", :author=>["Duby"]}}}}]
  end
  
  # Combination genus names should be merged without dash or capital letter
  it 'should parse hybrid names with capitalized second name in genus (botanical code error)' do
    sn = 'Anacampti-Platanthera P. Fourn.'
    parse(sn).should_not be_nil
    canonical(sn).should == 'Anacamptiplatanthera'
    sn = 'Anacampti-Platanthera vulgaris P. Fourn.'
    parse(sn).should_not be_nil
    canonical(sn).should == 'Anacamptiplatanthera vulgaris'
  end

  it 'should parse genus names starting with uppercase letters AE OE' do
    sn = 'AEmona separata Broun 1921'
    canonical(sn).should == 'Aemona separata'
    sn = 'OEmona simplex White, 1855'
    canonical(sn).should == 'Oemona simplex'
  end
  #"Arthrosamanea eriorhachis (Harms & sine ref. ) Aubrév." -- ignore & sine ref. (means without reference)
  
=begin
  new stuff

   sn = "Orchidaceae × Asconopsis hort."
   canonical(sn).should == "Orchidaceae x Asconopsis"
   sn 
   Tamiops swinhoei near hainanus|Tamiops swinhoei near hainanus
   Conus textile form archiepiscopus|Conus textile form archiepiscopus|
   Crypticus pseudosericeus ssp. olivieri Desbrochers des Loges,1881|Crypticus pseudosericeus olivieri des
   Solanum nigrum subsp nigrum|Solanum nigrum subsp nigrum
   Protoglossus taeniatum author unknown|Protoglossus taeniatum author unknown
   Dupontiella (S. ?) bicolor|Dupontiella|
=end
end
