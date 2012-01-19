# encoding: UTF-8
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')

describe ScientificNameDirty do
  before(:all) do
   set_parser(ScientificNameDirtyParser.new)
  end
  
  it 'should parse clean names' do
    parse("Betula verucosa (L.) Bar. 1899").should_not be_nil
  end
  
  it 'should parse double parenthesis' do
    sn = "Eichornia crassipes ( (Martius) ) Solms-Laub."
    parse(sn).should_not be_nil
    value(sn).should == "Eichornia crassipes (Martius) Solms-Laub."
    details(sn).should == [{:genus=>{:string=>"Eichornia"}, :species=>{:string=>"crassipes", :authorship=>"( (Martius) ) Solms-Laub.", :combinationAuthorTeam=>{:authorTeam=>"Solms-Laub.", :author=>["Solms-Laub."]}, :basionymAuthorTeam=>{:authorTeam=>"Martius", :author=>["Martius"]}}}]
    pos(sn).should == {0=>["genus", 9], 10=>["species", 19], 23=>["author_word", 30], 34=>["author_word", 45]} 
  end
  
  it "should parse year without author" do
    sn = "Acarospora cratericola 1929"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 10], 11=>["species", 22], 23=>["year", 27]}
    details(sn).should == [{:genus=>{:string=>"Acarospora"}, :species=>{:string=>"cratericola", :year=>"1929"}}]
  end
  
  it 'should parse double years' do
    sn = "Tridentella tangeroae Bruce, 1987-92"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 11], 12=>["species", 21], 22=>["author_word", 27], 29=>["year", 36]}
    details(sn).should == [{:genus=>{:string=>"Tridentella"}, :species=>{:string=>"tangeroae", :authorship=>"Bruce, 1987-92", :basionymAuthorTeam=>{:authorTeam=>"Bruce", :author=>["Bruce"], :year=>"1987-92"}}}]
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
    details(sn).should == [{:genus=>{:string=>"Gymnodactylus"}, :species=>{:string=>"irregularis", :authorship=>"WERMUTH 1965: 54", :basionymAuthorTeam=>{:authorTeam=>"WERMUTH", :author=>["WERMUTH"], :year=>"1965"}}}]
    pos(sn).should ==  {0=>["genus", 13], 14=>["species", 25], 26=>["author_word", 33], 34=>["year", 38]} 
  end
  
  it 'should parse year with []' do
    parse("Anthoscopus Cabanis [1851]").should_not be_nil
    value("Anthoscopus Cabanis [185?]").should == "Anthoscopus Cabanis (185?)"
    parse("Anthoscopus Cabanis [1851?]").should_not be_nil
    value("Anthoscopus Cabanis [1851]").should == "Anthoscopus Cabanis (1851)"
    sn = "Anthoscopus Cabanis [1851?]"
    value(sn).should == "Anthoscopus Cabanis (1851?)"
    details(sn).should == [{:uninomial=>{:string=>"Anthoscopus", :authorship=>"Cabanis [1851?]", :basionymAuthorTeam=>{:authorTeam=>"Cabanis", :author=>["Cabanis"], :approximate_year=>"(1851?)"}}}]
    pos(sn).should == {0=>["uninomial", 11], 12=>["author_word", 19], 21=>["year", 26]}
    sn = "Trismegistia monodii Ando, 1973 [1974]"
    parse(sn).should_not be_nil
    value(sn).should == 'Trismegistia monodii Ando 1973 (1974)' #should it be 'Trismegistia monodii Ando 1973 (1974)' instead?
    details(sn).should == [{:genus=>{:string=>"Trismegistia"}, :species=>{:string=>"monodii", :authorship=>"Ando, 1973 [1974]", :basionymAuthorTeam=>{:authorTeam=>"Ando", :author=>["Ando"], :year=>"1973", :approximate_year=>"(1974)"}}}]
    pos(sn).should ==  {0=>["genus", 12], 13=>["species", 20], 21=>["author_word", 25], 27=>["year", 31], 33=>["year", 37]} 
    parse("Zygaena witti Wiegel [1973]").should_not be_nil
    sn = "Deyeuxia coarctata Kunth, 1815 [1816]"
    parse(sn).should_not be_nil
    pos(sn).should == {0=>["genus", 8], 9=>["species", 18], 19=>["author_word", 24], 26=>["year", 30], 32=>["year", 36]}
  end
  
  it "should parse new stuff" do
    sn = 'Zoropsis (TaKeoa) nishimurai Yaginuma, 1971' #skipping for now
    sn = 'Campylobacter pyloridis Marshall et al.1985.'
    details(sn).should == [{:genus=>{:string=>"Campylobacter"}, :species=>{:string=>"pyloridis", :authorship=>"Marshall et al.1985.", :basionymAuthorTeam=>{:authorTeam=>"Marshall et al.", :author=>["Marshall et al."], :year=>"1985"}}}]
    sn = 'Staphylococcus hyicus chromogenes Devriese et al. 1978 (Approved Lists 1980).'
    details(sn).should == [{:genus=>{:string=>"Staphylococcus"}, :species=>{:string=>"hyicus"}, :infraspecies=>[{:string=>"chromogenes", :rank=>"n/a", :authorship=>"Devriese et al. 1978", :basionymAuthorTeam=>{:authorTeam=>"Devriese et al.", :author=>["Devriese et al."], :year=>"1978"}}]}]
    sn = 'Kitasatospora corrig. griseola Takahashi et al. 1985.'
    details(sn).should == [{:genus=>{:string=>"Kitasatospora"}, :species=>{:string=>"griseola", :authorship=>"Takahashi et al. 1985.", :basionymAuthorTeam=>{:authorTeam=>"Takahashi et al.", :author=>["Takahashi et al."], :year=>"1985"}}}]
    sn = 'Beijerinckia derxii venezuelae corrig. Thompson and Skerman, 1981'
    details(sn).should == [{:genus=>{:string=>"Beijerinckia"}, :species=>{:string=>"derxii"}, :infraspecies=>[{:string=>"venezuelae", :rank=>"n/a", :authorship=>"Thompson and Skerman, 1981", :basionymAuthorTeam=>{:authorTeam=>"Thompson and Skerman", :author=>["Thompson", "Skerman"], :year=>"1981"}}]}]
    details('Streptomyces parvisporogenes ignotus 1960').should == [{:genus=>{:string=>"Streptomyces"}, :species=>{:string=>"parvisporogenes"}, :infraspecies=>[{:string=>"ignotus", :rank=>"n/a", :year=>"1960"}]}]
    details('Oscillaria caviae Simons 1920, according to Simons 1922').should == [{:genus=>{:string=>"Oscillaria"}, :species=>{:string=>"caviae", :authorship=>"Simons 1920", :basionymAuthorTeam=>{:authorTeam=>"Simons", :author=>["Simons"], :year=>"1920"}}}]
    sn = 'Bacterium monocytogenes hominis"" Nyfeldt 1932'
    details(sn).should == [{:genus=>{:string=>"Bacterium"}, :species=>{:string=>"monocytogenes"}, :infraspecies=>[{:string=>"hominis", :rank=>"n/a"}]}]
    sn = 'Choriozopella trägårdhi Lawrence, 1947'
    details(sn).should == [{:genus=>{:string=>"Choriozopella"}, :species=>{:string=>"tragardhi", :authorship=>"Lawrence, 1947", :basionymAuthorTeam=>{:authorTeam=>"Lawrence", :author=>["Lawrence"], :year=>"1947"}}}]
    sn = 'Sparassus françoisi Simon, 1898'
    details(sn).should == [{:genus=>{:string=>"Sparassus"}, :species=>{:string=>"francoisi", :authorship=>"Simon, 1898", :basionymAuthorTeam=>{:authorTeam=>"Simon", :author=>["Simon"], :year=>"1898"}}}]
    sn = 'Dyarcyops birói Kulczynski, 1908'
    details(sn).should == [{:genus=>{:string=>"Dyarcyops"}, :species=>{:string=>"biroi", :authorship=>"Kulczynski, 1908", :basionymAuthorTeam=>{:authorTeam=>"Kulczynski", :author=>["Kulczynski"], :year=>"1908"}}}]
  end
  
  it 'should parse names with "common" utf-8 charactes' do
    names = ["Rühlella","Sténométope laevissimus Bibron 1855", "Döringina Ihering 1929"].each do |name|
      parse(name).should_not be_nil
    end
  end
  
# AsterophUa japonica
# AsyTuktus ridiculw Parent 1931
# AtremOEa Staud 1870


end
