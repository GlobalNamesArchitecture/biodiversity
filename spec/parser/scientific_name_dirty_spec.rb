# encoding: UTF-8
require_relative '../spec_helper'

describe ScientificNameDirty do
  before(:all) do
   set_parser(ScientificNameDirtyParser.new)
  end
  
  it 'parses clean names' do
    expect(parse('Betula verucosa (L.) Bar. 1899')).to_not be_nil
  end
  
  it 'parses double parenthesis' do
    sn = 'Eichornia crassipes ( (Martius) ) Solms-Laub.'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Eichornia crassipes (Martius) Solms-Laub.'
    expect(details(sn)).to eq [{ genus: { string: 'Eichornia' }, 
      species: { string: 'crassipes', 
      authorship: '( (Martius) ) Solms-Laub.', 
      combinationAuthorTeam: { authorTeam: 'Solms-Laub.', 
        author: ['Solms-Laub.'] }, 
        basionymAuthorTeam: { authorTeam: 'Martius', 
          author: ['Martius'] } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 9], 10 => ['species', 19],
                           23 => ['author_word', 30], 
                           34 => ['author_word', 45] })
  end
  
  it 'parses year without author' do
    sn = 'Acarospora cratericola 1929'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 10],
                           11 => ['species', 22], 23 => ['year', 27] })
    expect(details(sn)).to eq [{ genus: { string: 'Acarospora' }, 
                                species: { string: 'cratericola', 
                                           year: '1929' } }]
  end
  
  it 'parses double years' do
    sn = 'Tridentella tangeroae Bruce, 1987-92'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 11], 12 => ['species', 21], 
                           22 => ['author_word', 27], 29 => ['year', 36] })
    expect(details(sn)).to eq [{ genus: { string: 'Tridentella' }, 
      species: { string: 'tangeroae', authorship: 'Bruce, 1987-92', 
      basionymAuthorTeam: { authorTeam: 'Bruce', author: ['Bruce'], 
      year: '1987-92' } } }]
  end
  
  it 'parses dirty years' do
    expect(parse('Tridentella tangeroae Bruce, 1988B')).to_not be_nil
    expect(parse('Tridentella tangeroae Bruce, 1988b')).to_not be_nil
    expect(parse('Tridentella tangeroae Bruce, 1988d')).to_not be_nil
    sn = 'Tridentella tangeroae Bruce, 198?'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 11], 12 => ['species', 21], 
                           22 => ['author_word', 27], 29 => ['year', 33] })
  end
  
  it 'parses year with page number' do
    sn = 'Gymnodactylus irregularis WERMUTH 1965: 54'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Gymnodactylus irregularis Wermuth 1965'
    expect(details(sn)).to eq [{ genus: { string: 'Gymnodactylus' }, 
      species: { string: 'irregularis', authorship: 'WERMUTH 1965: 54', 
      basionymAuthorTeam: { authorTeam: 'WERMUTH', author: ['Wermuth'], 
      year: '1965' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 13], 14 => ['species', 25], 
                           26 => ['author_word', 33], 34 => ['year', 38] })
  end
  
  it 'parses year with []' do
    expect(parse('Anthoscopus Cabanis [1851]')).to_not be_nil
    expect(value('Anthoscopus Cabanis [185?]')).
      to eq 'Anthoscopus Cabanis (185?)'
    expect(parse('Anthoscopus Cabanis [1851?]')).to_not be_nil
    expect(value('Anthoscopus Cabanis [1851]')).
      to eq 'Anthoscopus Cabanis (1851)'
    sn = 'Anthoscopus Cabanis [1851?]'
    expect(value(sn)).to eq 'Anthoscopus Cabanis (1851?)'
    expect(details(sn)).to eq [{ uninomial: { string: 'Anthoscopus', 
      authorship: 'Cabanis [1851?]', basionymAuthorTeam: 
      { authorTeam: 'Cabanis', author: ['Cabanis'], 
      approximate_year: '(1851?)' } } }]
    expect(pos(sn)).to eq({ 0 => ['uninomial', 11], 
                           12 => ['author_word', 19], 21 => ['year', 26] })
    sn = 'Trismegistia monodii Ando, 1973 [1974]'
    expect(parse(sn)).to_not be_nil

    #should it be 'Trismegistia monodii Ando 1973 (1974)' instead?
    expect(value(sn)).to eq 'Trismegistia monodii Ando 1973 (1974)' 
    
    expect(details(sn)).to eq [{ genus: { string: 'Trismegistia' }, 
      species: { string: 'monodii', authorship: 'Ando, 1973 [1974]', 
      basionymAuthorTeam: { authorTeam: 'Ando', author: ['Ando'], 
      year: '1973', approximate_year: '(1974)' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 20], 
      21 => ['author_word', 25], 27 => ['year', 31], 33 => ['year', 37] })
    expect(parse('Zygaena witti Wiegel [1973]')).to_not be_nil
    sn = 'Deyeuxia coarctata Kunth, 1815 [1816]'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 8], 9 => ['species', 18], 
                          19 => ['author_word', 24], 26 => ['year', 30], 
                          32 => ['year', 36] })
  end
  
  it 'parses new stuff' do
    sn = 'Zoropsis (TaKeoa) nishimurai Yaginuma, 1971' #skipping for now
    sn = 'Campylobacter pyloridis Marshall et al.1985.'
    expect(details(sn)).to eq [{ genus: { string: 'Campylobacter' }, 
      species: { string: 'pyloridis', authorship: 'Marshall et al.1985.', 
      basionymAuthorTeam: { authorTeam: 'Marshall et al.', 
      author: ['Marshall et al.'], year: '1985' } } }]
    sn = 'Beijerinckia derxii venezuelae corrig. Thompson and Skerman, 1981'
    expect(details(sn)).to eq [{ genus: { string: 'Beijerinckia' }, 
      species: { string: 'derxii' }, infraspecies: [{ string: 'venezuelae', 
      rank: 'n/a', authorship: 'Thompson and Skerman, 1981', 
      basionymAuthorTeam: { authorTeam: 'Thompson and Skerman', 
      author: ['Thompson', 'Skerman'], year: '1981' } }] }]
    expect(details('Streptomyces parvisporogenes ignotus 1960')).
      to eq [{ genus: { string: 'Streptomyces' }, 
        species: { string: 'parvisporogenes' }, 
        infraspecies: [{ string: 'ignotus', rank: 'n/a', year: '1960' }] }]
    expect(details('Oscillaria caviae Simons 1920, according to Simons 1922')).
      to eq [{ genus: { string: 'Oscillaria' }, species: { string: 'caviae', 
        authorship: 'Simons 1920', basionymAuthorTeam: 
        { authorTeam: 'Simons', author: ['Simons'], year: '1920' } } }]
    sn = 'Bacterium monocytogenes hominis\'\' Nyfeldt 1932'
    expect(details(sn)).to eq [{ genus: { string: 'Bacterium' }, 
      species: { string: 'monocytogenes' }, 
      infraspecies: [{ string: 'hominis', rank: 'n/a' }] }]
    sn = 'Choriozopella trägårdhi Lawrence, 1947'
    expect(details(sn)).to eq [{ genus: { string: 'Choriozopella' }, 
      species: { string: 'tragardhi', authorship: 'Lawrence, 1947', 
      basionymAuthorTeam: { authorTeam: 'Lawrence', author: ['Lawrence'], 
      year: '1947' } } }]
    sn = 'Sparassus françoisi Simon, 1898'
    expect(details(sn)).to eq [{ genus: { string: 'Sparassus' }, 
      species: { string: 'francoisi', authorship: 'Simon, 1898', 
      basionymAuthorTeam: { authorTeam: 'Simon', author: ['Simon'], 
      year: '1898' } } }]
    sn = 'Dyarcyops birói Kulczynski, 1908'
    expect(details(sn)).to eq [{ genus: { string: 'Dyarcyops' }, 
      species: { string: 'biroi', authorship: 'Kulczynski, 1908', 
      basionymAuthorTeam: { authorTeam: 'Kulczynski', 
      author: ['Kulczynski'], year: '1908' } } }]
  end
  
  it 'parses names with common utf-8 charactes' do
    names = ['Rühlella','Sténométope laevissimus Bibron 1855', 
             'Döringina Ihering 1929'].each do |name|
      expect(parse(name)).to_not be_nil
    end
    expect(details('Hirsutëlla mâle')).to eq [{ genus: { string: 'Hirsutella' }, 
                                              species: { string: 'male' } }] 
    expect(details('Triticum repens vulgäre')).
      to eq [{ genus: { string: 'Triticum' }, species: { string: 'repens' }, 
              infraspecies: [{ string: 'vulgare', rank: 'n/a' }] }]
  end
  
# AsterophUa japonica
# AsyTuktus ridiculw Parent 1931
# AtremOEa Staud 1870


end
