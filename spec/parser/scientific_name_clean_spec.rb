# encoding: UTF-8
require_relative '../spec_helper'


describe ScientificNameClean do
  before(:all) do
    set_parser(ScientificNameCleanParser.new)
  end

  it 'parses uninomial' do
    sn = 'Pseudocercospora'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora'
    expect(canonical(sn)).to eq 'Pseudocercospora'
    expect(details(sn)).to eq [{ uninomial: { string: 'Pseudocercospora' } }]
    expect(pos(sn)).to eq({  0 => ['uninomial', 16]  })
  end
  
  it 'parses uninomial with author and year' do
    sn = 'Pseudocercospora Speg.'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ uninomial: 
                            { string: 'Pseudocercospora', 
                             authorship: 'Speg.', 
                             basionymAuthorTeam: 
                          { authorTeam: 'Speg.', author: ['Speg.'] } } }]
    expect(pos(sn)).to eq({ 0 => ['uninomial', 16], 17 => ['author_word', 22] })
    sn = 'Pseudocercospora Spegazzini, 1910'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora Spegazzini 1910'
    expect(details(sn)).to eq [{ uninomial: 
                            { string: 'Pseudocercospora', 
                             authorship: 'Spegazzini, 1910', 
                             basionymAuthorTeam: 
                            { authorTeam: 'Spegazzini', 
                             author: ['Spegazzini'], year: '1910' } } }]
    expect(pos(sn)).to eq({ 0 => ['uninomial', 16], 
                       17 => ['author_word', 27], 29 => ['year', 33] })
  end

  it 'parses uninomials with uninomial ranks' do
    sn = 'Epacridaceae trib. Archerieae Crayn & Quinn'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ uninomial: 
                            { string: 'Epacridaceae' }, 
                              rank_uninomials: 'trib.', 
                              :uninomial2 => { string: 'Archerieae', 
                                            authorship: 'Crayn & Quinn', 
                                            basionymAuthorTeam: 
                            { authorTeam: 'Crayn & Quinn', 
                             author: ['Crayn', 'Quinn'] } } }]
  end

  it 'parses names with a valid 2 letter genus' do
    ['Ca Dyar 1914',
    'Ea Distant 1911',
    'Ge Nicéville 1895',
    'Ia Thomas 1902',
    'Io Lea 1831',
    'Io Blanchard 1852',
    'Ix Bergroth 1916',
    'Lo Seale 1906',
    'Oa Girault 1929',
    'Ra Whitley 1931',
    'Ty Bory de St. Vincent 1827',
    'Ua Girault 1929',
    'Aa Baker 1940',
    'Ja Uéno 1955',
    'Zu Walters & Fitch 1960',
    'La Bleszynski 1966',
    'Qu Durkoop',
    'As Slipinski 1982',
    'Ba Solem 1983'].each do |name|
      expect(parse(name)).to_not be_nil
    end
    expect(canonical('Quoyula')).to eq 'Quoyula'
  end

  it 'parses canonical' do
    sn = 'Pseudocercospora     dendrobii'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii'
    expect(canonical(sn)).to eq 'Pseudocercospora dendrobii'
    expect(details(sn)).to eq [{ genus: 
                            { string: 'Pseudocercospora' }, 
                              species: { string: 'dendrobii' } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 16], 21 => ['species', 30] })
  end

  it 'parses abbreviated canonical' do
    sn = 'P.    dendrobii'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'P. dendrobii'
    sn = 'Ps.    dendrobii'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Ps. dendrobii'
    expect(details(sn)).to eq [{ genus: 
                            { string: 'Ps.' }, 
                              species: { string: 'dendrobii' } }]
  end


  it 'parses species name with author and year' do
    sn = 'Platypus bicaudatulus Schedl 1935'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Platypus bicaudatulus Schedl 1935'
    sn = 'Platypus bicaudatulus Schedl, 1935h'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Platypus bicaudatulus Schedl 1935'
    expect(details(sn)).to eq [{ genus: 
                            { string: 'Platypus' }, 
                              species: { string: 'bicaudatulus', 
                                         authorship: 'Schedl, 1935h', 
                                         basionymAuthorTeam: 
                            { authorTeam: 'Schedl', author: ['Schedl'], 
                             year: '1935' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 8],
                       9 => ['species', 21], 22 => ['author_word', 28], 
                       30 => ['year', 35] })
    expect(parse('Platypus bicaudatulus Schedl, 1935B')).to_not be_nil
    sn = 'Platypus bicaudatulus Schedl (1935h)'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Platypus' }, 
      species: { string: 'bicaudatulus', authorship: 'Schedl (1935h)', 
      basionymAuthorTeam: { authorTeam: 'Schedl', author: ['Schedl'], 
      year: '1935' } } }]
    expect(parse('Platypus bicaudatulus Schedl 1935')).to_not be_nil
  end

  it 'parses species name with abbreviated genus, author and year' do
    sn = 'P. bicaudatulus Schedl 1935'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'P. bicaudatulus Schedl 1935'
    sn = 'Pl.  bicaudatulus Schedl, 1935h'
    expect(parse(sn)).not_to be_nil
    expect(value(sn)).to eq 'Pl. bicaudatulus Schedl 1935'
    expect(details(sn)).to eq [{ genus: { string: 'Pl.' }, 
      species: { string: 'bicaudatulus', authorship: 'Schedl, 1935h', 
      basionymAuthorTeam: { authorTeam: 'Schedl', 
      author: ['Schedl'], year: '1935' } } }]
    sn = 'Pla.  bicaudatulus Schedl, 1935h'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pla. bicaudatulus Schedl 1935'
  end

  it 'parses species name with author\'s postfix f., filius (son of)' do
    names = [
      ['Platypus bicaudatulus Schedl f. 1935', [{ genus: { string: 'Platypus' }, 
          species: { string: 'bicaudatulus', authorship: 'Schedl f. 1935', 
          basionymAuthorTeam: { authorTeam: 'Schedl f.', 
          author: ['Schedl f.'], year: '1935' } } }], 
        'Platypus bicaudatulus Schedl f. 1935'], 
          ['Platypus bicaudatulus Schedl filius 1935', 
           [{ genus: { string: 'Platypus' }, 
             species: { string: 'bicaudatulus', 
             authorship: 'Schedl filius 1935', 
             basionymAuthorTeam: { authorTeam: 'Schedl filius', 
             author: ['Schedl filius'], year: '1935' } } }], 
             'Platypus bicaudatulus Schedl filius 1935'],
      ['Fimbristylis ovata (Burm. f.) J. Kern', 
        [{ genus: { string: 'Fimbristylis' }, species: { string: 'ovata', 
          authorship: '(Burm. f.) J. Kern', 
          combinationAuthorTeam: { authorTeam: 'J. Kern', 
          author: ['J. Kern'] }, 
          basionymAuthorTeam: { authorTeam: 'Burm. f.', 
          author: ['Burm. f.'] } } }], 'Fimbristylis ovata (Burm. f.) J. Kern'],
      ['Carex chordorrhiza Ehrh. ex L. f.', 
        [{ genus: { string: 'Carex' }, species: { string: 'chordorrhiza', 
          authorship: 'Ehrh. ex L. f.', 
          basionymAuthorTeam: { authorTeam: 'Ehrh.', 
          author: ['Ehrh.'], exAuthorTeam: { authorTeam: 'L. f.', 
          author: ['L. f.'] } } } }], 'Carex chordorrhiza Ehrh. ex L. f.'],
      ['Amelanchier arborea var. arborea (Michx. f.) Fernald', 
        [{ genus: { string: 'Amelanchier' }, species: { string: 'arborea'}, 
          infraspecies: [{ string: 'arborea', rank: 'var.', 
          authorship: '(Michx. f.) Fernald', combinationAuthorTeam: {
          authorTeam: 'Fernald', author: ['Fernald'] }, 
          basionymAuthorTeam: { authorTeam: 'Michx. f.', 
          author: ['Michx. f.'] } }]}], 
          'Amelanchier arborea var. arborea (Michx. f.) Fernald'],
      ['Cerastium arvense var. fuegianum Hook. f.', 
        [{ genus: { string: 'Cerastium' }, species: { string: 'arvense'}, 
          infraspecies: [{ string: 'fuegianum', rank: 'var.', 
          authorship: 'Hook. f.', 
          basionymAuthorTeam: { authorTeam: 'Hook. f.', 
          author: ['Hook. f.'] } }]}], 
          'Cerastium arvense var. fuegianum Hook. f.'],
      ['Cerastium arvense var. fuegianum Hook.f.', 
        [{ genus: { string: 'Cerastium' }, species: { string: 'arvense'}, 
          infraspecies: [{ string: 'fuegianum', rank: 'var.', 
          authorship: 'Hook.f.', basionymAuthorTeam: {
          authorTeam: 'Hook.f.', author: ['Hook.f.'] } }]}], 
          'Cerastium arvense var. fuegianum Hook.f.'],
      ['Cerastium arvense ssp. velutinum var. velutinum (Raf.) Britton f.', 
        [{ genus: { string: 'Cerastium' }, species: { string: 'arvense'}, 
          infraspecies: [{ string: 'velutinum', rank: 'ssp.' }, 
          { string: 'velutinum', rank: 'var.', 
          authorship: '(Raf.) Britton f.', 
          combinationAuthorTeam: { authorTeam: 'Britton f.', 
          author: ['Britton f.'] }, basionymAuthorTeam: { authorTeam: 'Raf.', 
          author: ['Raf.'] } }]}], 
          'Cerastium arvense ssp. velutinum var. velutinum (Raf.) Britton f.'],
      ['Amelanchier arborea f. hirsuta (Michx. f.) Fernald', 
        [{ infraspecies: [{ basionymAuthorTeam: { author: ['Michx. f.'], 
        authorTeam: 'Michx. f.' }, string: 'hirsuta', rank: 'f.', 
        combinationAuthorTeam: { author: ['Fernald'], authorTeam: 'Fernald' }, 
        authorship: '(Michx. f.) Fernald' }], genus: { string: 'Amelanchier'}, 
        species: { string: 'arborea' } }], 
        'Amelanchier arborea f. hirsuta (Michx. f.) Fernald'],
      ['Betula pendula fo. dalecarlica (L. f.) C.K. Schneid.', 
        [{ infraspecies: [{ basionymAuthorTeam: { author: ['L. f.'], 
          authorTeam: 'L. f.' }, string: 'dalecarlica', rank: 'fo.', 
          combinationAuthorTeam: { author: ['C.K. Schneid.'], 
          authorTeam: 'C.K. Schneid.' }, authorship: '(L. f.) C.K. Schneid.'}], 
          genus: { string: 'Betula' }, species: { string: 'pendula'} }], 
          'Betula pendula fo. dalecarlica (L. f.) C.K. Schneid.'],
      ['Racomitrium canescens f. ericoides (F. Weber ex Brid.) Mönk.', 
        [{ genus: { string: 'Racomitrium' }, species: { string: 'canescens'}, 
          infraspecies: [{ string: 'ericoides', rank: 'f.', 
          authorship: '(F. Weber ex Brid.) Mönk.', 
          combinationAuthorTeam: { authorTeam: 'Mönk.', author: ['Mönk.'] }, 
          basionymAuthorTeam: { authorTeam: 'F. Weber', 
          author: ['F. Weber'], exAuthorTeam: { authorTeam: 'Brid.', 
          author: ['Brid.'] } } }]}], 
          'Racomitrium canescens f. ericoides (F. Weber ex Brid.) Mönk.'],
      ['Racomitrium canescens forma ericoides (F. Weber ex Brid.) Mönk.', 
        [{ genus: { string: 'Racomitrium' }, species: { string: 'canescens'}, 
          infraspecies: [{ string: 'ericoides', rank: 'forma', 
          authorship: '(F. Weber ex Brid.) Mönk.', 
          combinationAuthorTeam: { authorTeam: 'Mönk.', author: ['Mönk.'] }, 
          basionymAuthorTeam: { authorTeam: 'F. Weber', author: ['F. Weber'], 
          exAuthorTeam: { authorTeam: 'Brid.', author: ['Brid.'] } } }]}], 
          'Racomitrium canescens forma ericoides (F. Weber ex Brid.) Mönk.'],
      ['Peristernia nassatula forskali Tapparone-Canefri 1875', 
        [{ genus: { string: 'Peristernia' }, species: { string: 'nassatula'}, 
          infraspecies: [{ string: 'forskali', rank: 'n/a', 
          authorship: 'Tapparone-Canefri 1875', basionymAuthorTeam: {
          authorTeam: 'Tapparone-Canefri', author: ['Tapparone-Canefri'], 
          year: '1875' } }]}], 
          'Peristernia nassatula forskali Tapparone-Canefri 1875'],
    ]
    names.each do |sn, sn_details, sn_value|
      expect(parse(sn)).to_not be_nil
      expect(details(sn)).to eq sn_details
      expect(value(sn)).to eq sn_value
    end
  end

  it 'parses genus with "?"' do
    sn = 'Ferganoconcha? oblonga'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Ferganoconcha oblonga'
    expect(details(sn)).to eq [{ genus: { string: 'Ferganoconcha' }, 
      species: { string: 'oblonga' } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 14], 15 => ['species', 22] })
  end

  it 'parses æ in the name' do
    names = [
      ['Læptura laetifica Dow, 1913', 'Laeptura laetifica Dow 1913'],
      ['Leptura lætifica Dow, 1913', 'Leptura laetifica Dow 1913'],
      ['Leptura leætifica Dow, 1913', 'Leptura leaetifica Dow 1913'],
      ['Leæptura laetifica Dow, 1913', 'Leaeptura laetifica Dow 1913'],
      ['Leœptura laetifica Dow, 1913', 'Leoeptura laetifica Dow 1913'],
      ['Ærenea cognata Lacordaire, 1872', 'Aerenea cognata Lacordaire 1872'],
      ['Œdicnemus capensis', 'Oedicnemus capensis'],
      ['Œnanthæ œnanthe','Oenanthae oenanthe'],
      ['Œnanthe œnanthe','Oenanthe oenanthe'],
      ['Cerambyx thomæ Gmelin J. F., 1790', 'Cerambyx thomae Gmelin J. F. 1790']
    ]
    names.each do |name_pair|
      expect(parse(name_pair[0])).to_not be_nil
      expect(value(name_pair[0])).to eq name_pair[1]
    end
  end

  it 'parses names with e-umlaut' do
   sn = 'Kalanchoë tuberosa'
   expect(canonical(sn)).to eq 'Kalanchoe tuberosa'
   sn = 'Isoëtes asplundii H. P. Fuchs'
   expect(canonical(sn)).to eq 'Isoetes asplundii'
  end

  it 'parses infragenus (ICZN code)' do
    sn = 'Hegeter (Hegeter) intercedens Lindberg H 1950'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Hegeter (Hegeter) intercedens Lindberg H 1950'
    expect(canonical(sn)).to eq 'Hegeter intercedens'
    expect(details(sn)).to eq [{ genus: { string: 'Hegeter' }, 
      infragenus: { string: 'Hegeter' }, species: { string: 'intercedens', 
      authorship: 'Lindberg H 1950', 
      basionymAuthorTeam: { authorTeam: 'Lindberg H', 
        author: ['Lindberg H'], year: '1950' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 7], 9 => ['infragenus', 16], 
      18 => ['species', 29], 30 => ['author_word', 38], 
      39 => ['author_word', 40], 41 => ['year', 45] })
    sn = 'Ixodes (Ixodes) hexagonus hexagonus Neumann, 1911'
    expect(canonical(sn)).to eq 'Ixodes hexagonus hexagonus'
    sn = 'Brachytrypus (B.) grandidieri'
    expect(canonical(sn)).to eq 'Brachytrypus grandidieri'
    expect(details(sn)).to eq [{ genus: { string: 'Brachytrypus' }, 
      infragenus: { string: 'B.' }, species: { string: 'grandidieri'} }]
    sn = 'Empis (Argyrandrus) Bezzi 1909'
    expect(details(sn)).to eq [{ uninomial: { string: 'Empis', 
      infragenus: { string: 'Argyrandrus' }, authorship: 'Bezzi 1909', 
      basionymAuthorTeam: { authorTeam: 'Bezzi', 
      author: ['Bezzi'], year: '1909' } } }]
    sn = 'Platydoris (Bergh )'
    expect(details(sn)).to eq [{ uninomial: { string: 'Platydoris', 
      infragenus: { string: 'Bergh' } } }]
    expect(value(sn)).to eq 'Platydoris (Bergh)'
    sn = 'Platydoris (B.)'
    expect(details(sn)).to eq [{ uninomial: { string: 'Platydoris', 
      infragenus: { string: 'B.' } } }]
  end

  it 'parses several authors without a year' do
    sn = 'Pseudocercospora dendrobii U. Braun & Crous'
    expect(parse(sn)).to_not be be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii U. Braun & Crous'
    expect(canonical(sn)).to eq 'Pseudocercospora dendrobii'
    expect(details(sn)).to eq  [{ genus: { string: 'Pseudocercospora' }, 
      species: { string: 'dendrobii', authorship: 'U. Braun & Crous', 
      basionymAuthorTeam: { authorTeam: 'U. Braun & Crous', 
      author: ['U. Braun', 'Crous'] } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 16], 17 => ['species', 26], 
      27 => ['author_word', 29], 30 => ['author_word', 35], 
      38 => ['author_word', 43] })
    sn = 'Pseudocercospora dendrobii U. Braun and Crous'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii U. Braun & Crous'
    expect(pos(sn)).to eq({ 0 => ['genus', 16], 17 => ['species', 26], 
      27 => ['author_word', 29], 30 => ['author_word', 35], 
      40 => ['author_word', 45] })
    sn = 'Pseudocercospora dendrobii U. Braun et Crous'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii U. Braun & Crous'
    sn = 'Arthopyrenia hyalospora(Nyl.)R.C.     Harris'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Arthopyrenia hyalospora (Nyl.) R.C. Harris'
    expect(canonical(sn)).to eq 'Arthopyrenia hyalospora'
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora', authorship: '(Nyl.)R.C.     Harris', 
      combinationAuthorTeam: { authorTeam: 'R.C.     Harris', 
      author: ['R.C. Harris'] }, 
      basionymAuthorTeam: { authorTeam: 'Nyl.', author: ['Nyl.'] } } }]
  end

  it 'parses several authors with a year' do
    sn = 'Pseudocercospora dendrobii U. Braun & Crous 2003'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii U. Braun & Crous 2003'
    expect(canonical(sn)).to eq 'Pseudocercospora dendrobii'
    expect(details(sn)).to eq [{ genus: { string: 'Pseudocercospora' }, 
      species: { string: 'dendrobii', authorship: 'U. Braun & Crous 2003', 
      basionymAuthorTeam: { authorTeam: 'U. Braun & Crous', 
      author: ['U. Braun', 'Crous'], year: '2003' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 16], 17 => ['species', 26], 
      27 => ['author_word', 29], 30 => ['author_word', 35], 
      38 => ['author_word', 43], 44 => ['year', 48] })
    sn = 'Pseudocercospora dendrobii Crous, 2003'
    expect(parse(sn)).to_not be_nil
  end

  it 'parses basionym authors in parenthesis' do
    sn = 'Zophosis persis (Chatanay, 1914)'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Zophosis' }, 
      species: { string: 'persis', authorship: '(Chatanay, 1914)', 
      basionymAuthorTeam: { authorTeam: 'Chatanay', 
      author: ['Chatanay'], year: '1914' } } }]
    sn = 'Zophosis persis (Chatanay 1914)'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Zophosis' }, 
      species: { string: 'persis', authorship: '(Chatanay 1914)', 
      basionymAuthorTeam: { authorTeam: 'Chatanay', 
      author: ['Chatanay'], year: '1914' } } }]
    sn = 'Zophosis persis (Chatanay), 1914'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Zophosis persis (Chatanay 1914)'
    expect(details(sn)).to eq [{ genus: { string: 'Zophosis' }, 
      species: { string: 'persis', authorship: '(Chatanay), 1914', 
      basionymAuthorTeam: { author_team: '(Chatanay), 1914', 
      author: ['Chatanay'], year: '1914' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 8], 9 => ['species', 15], 
      17 => ['author_word', 25], 28 => ['year', 32] })
    expect(parse('Zophosis persis (Chatanay) 1914')).to_not be_nil
    #parse('Zophosis persis Chatanay (1914)')).to_not be_nil
  end

  it 'parses name with identificaation annotation -- aff cf sp spp' do
    sn = 'Diplocephalus aff. procerus Thaler, 1972'
    expect(details(sn)).to eq [{ genus: { string: 'Diplocephalus' }, 
      annotation_identification: 'aff.', 
      ignored: { species: { string: 'procerus', authorship: 'Thaler, 1972', 
      basionymAuthorTeam: { authorTeam: 'Thaler', 
      author: ['Thaler'], year: '1972' } } } }]
    sn = 'Diplocephalus aff procerus Thaler, 1972'
    expect(details(sn)).to eq [{ genus: { string: 'Diplocephalus' }, 
      annotation_identification: 'aff', ignored: { species: 
      { string: 'procerus', authorship: 'Thaler, 1972', 
      basionymAuthorTeam: { authorTeam: 'Thaler', 
      author: ['Thaler'], year: '1972' } } } }]
    sn = 'Diplocephalus affprocerus Thaler, 1972'
    expect(details(sn)).to eq [{ genus: { string: 'Diplocephalus' }, 
      species: { string: 'affprocerus', authorship: 'Thaler, 1972', 
      basionymAuthorTeam: { authorTeam: 'Thaler', 
      author: ['Thaler'], year: '1972' } } }]
    sn = 'Diplocephalus cf. procerus Thaler, 1972'
    expect(details(sn)).to eq [{ genus: { string: 'Diplocephalus' }, 
      annotation_identification: 'cf.', species: { species: 
      { string: 'procerus', authorship: 'Thaler, 1972', 
      basionymAuthorTeam: { authorTeam: 'Thaler', 
      author: ['Thaler'], year: '1972' } } } }]
    sn = 'Diplocephalus cf procerus Thaler, 1972'
    expect(details(sn)).to eq [{ genus: { string: 'Diplocephalus' }, 
      annotation_identification: 'cf', species: 
      { species: { string: 'procerus', authorship: 'Thaler, 1972', 
      basionymAuthorTeam: { authorTeam: 'Thaler', 
      author: ['Thaler'], year: '1972' } } } }]
    sn = 'Sphingomonas sp. 37'
    expect(details(sn)).to eq [{ genus: { string: 'Sphingomonas' }, 
      annotation_identification: 'sp.', ignored: { unparsed: '37' } }]
    sn = 'Thryothorus leucotis spp. bogotensis'
    expect(details(sn)).to eq [{ genus: { string: 'Thryothorus' }, 
      species: { string: 'leucotis' }, infraspecies: 
      [{ annotation_identification: 'spp.', 
      ignored: { infraspecies: { string: 'bogotensis', rank: 'n/a' } } }]}]
  end

  it 'parses scientific name' do
    sn = 'Pseudocercospora dendrobii(H.C.     Burnett)U. Braun & Crous     2003'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii (H.C. Burnett) '\
                            'U. Braun & Crous 2003'
    expect(canonical(sn)).to eq 'Pseudocercospora dendrobii'
    expect(details(sn)).to eq [{ genus: { string: 'Pseudocercospora' }, 
      species: { string: 'dendrobii', 
      authorship: '(H.C.     Burnett)U. Braun & Crous     2003', 
      combinationAuthorTeam: { authorTeam: 'U. Braun & Crous', 
      author: ['U. Braun', 'Crous'], year: '2003' }, 
      basionymAuthorTeam: { authorTeam: 'H.C.     Burnett', 
      author: ['H.C. Burnett'] } } }]
    sn = 'Pseudocercospora dendrobii(H.C.     Burnett,1873)'\
         'U. Braun & Crous     2003'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii (H.C. Burnett 1873) '\
                            'U. Braun & Crous 2003'
    expect(details(sn)).to eq [{ genus: { string: 'Pseudocercospora' }, 
      species: { string: 'dendrobii', 
      authorship: '(H.C.     Burnett,1873)U. Braun & Crous     2003', 
      combinationAuthorTeam: { authorTeam: 'U. Braun & Crous', 
      author: ['U. Braun', 'Crous'], year: '2003' }, 
      basionymAuthorTeam: { authorTeam: 'H.C.     Burnett', 
      author: ['H.C. Burnett'], year: '1873' } } }]
  end

  it 'parses several authors with several years' do
    sn = 'Pseudocercospora dendrobii (H.C. Burnett 1883) U. Braun & Crous 2003'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Pseudocercospora dendrobii (H.C. Burnett 1883) '\
                            'U. Braun & Crous 2003'
    expect(canonical(sn)).to eq 'Pseudocercospora dendrobii'
    expect(details(sn)).to eq [{ genus: { string: 'Pseudocercospora' }, 
      species: { string: 'dendrobii', 
      authorship: '(H.C. Burnett 1883) U. Braun & Crous 2003', 
      combinationAuthorTeam: { authorTeam: 'U. Braun & Crous', 
      author: ['U. Braun', 'Crous'], year: '2003' }, 
      basionymAuthorTeam: { authorTeam: 'H.C. Burnett', 
      author: ['H.C. Burnett'], year: '1883' } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 16], 17 => ['species', 26], 
      28 => ['author_word', 32], 33 => ['author_word', 40], 
      41 => ['year', 45], 47 => ['author_word', 49], 
      50 => ['author_word', 55], 58 => ['author_word', 63], 
      64 => ['year', 68] })
  end

  it 'parses name with subspecies without rank Zoological Code' do
    sn = 'Hydnellum scrobiculatum zonatum (Banker) D. Hall & D.E. Stuntz 1972'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Hydnellum scrobiculatum zonatum (Banker) '\
                            'D. Hall & D.E. Stuntz 1972'
    expect(canonical(sn)).to eq 'Hydnellum scrobiculatum zonatum'
    expect(details(sn)).to eq [{ genus: { string: 'Hydnellum' }, 
      species: { string: 'scrobiculatum' }, 
      infraspecies: [{ string: 'zonatum', rank: 'n/a', 
      authorship: '(Banker) D. Hall & D.E. Stuntz 1972', 
      combinationAuthorTeam: { authorTeam: 'D. Hall & D.E. Stuntz', 
      author: ['D. Hall', 'D.E. Stuntz'], year: '1972' }, 
      basionymAuthorTeam: { authorTeam: 'Banker', author: ['Banker'] } }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 9], 10 => ['species', 23], 
      24 => ['infraspecies', 31], 33 => ['author_word', 39], 
      41 => ['author_word', 43], 44 => ['author_word', 48], 
      51 => ['author_word', 55], 56 => ['author_word', 62], 
      63 => ['year', 67] })
    sn = 'Begonia pingbienensis angustior'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Begonia' }, 
      species: { string: 'pingbienensis' }, 
      infraspecies: [{ string: 'angustior', rank: 'n/a' }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 7], 
      8 => ['species', 21], 22 => ['infraspecies', 31] })
  end

  it 'parses infraspecies with rank' do
    sn = 'Aus bus Linn. var. bus'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Aus' }, 
      species: { string: 'bus', authorship: 'Linn.', 
      basionymAuthorTeam: { authorTeam: 'Linn.', 
      author: ['Linn.'] } }, infraspecies: [{ string: 'bus', rank: 'var.'}]}]
    sn = 'Agalinis purpurea (L.) Briton var. borealis (Berg.) Peterson 1987'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Agalinis' }, 
      species: { string: 'purpurea', authorship: '(L.) Briton', 
      combinationAuthorTeam: { authorTeam: 'Briton', author: ['Briton'] }, 
      basionymAuthorTeam: { authorTeam: 'L.', 
      author: ['L.'] } }, infraspecies: [{ string: 'borealis', 
      rank: 'var.', authorship: '(Berg.) Peterson 1987', 
      combinationAuthorTeam: { authorTeam: 'Peterson', 
      author: ['Peterson'], year: '1987' }, 
      basionymAuthorTeam: { authorTeam: 'Berg.', author: ['Berg.'] } }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 8], 9 => ['species', 17], 
      19 => ['author_word', 21], 23 => ['author_word', 29], 
      30 => ['infraspecific_type', 34], 35 => ['infraspecies', 43], 
      45 => ['author_word', 50], 52 => ['author_word', 60], 
      61 => ['year', 65] })
    sn = 'Phaeographis inusta var. macularis(Leight.) A.L. Sm. 1861'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Phaeographis inusta var. macularis (Leight.) '\
                            'A.L. Sm. 1861'
    expect(canonical(sn)).to eq 'Phaeographis inusta macularis'
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 19], 
      20 => ['infraspecific_type', 24], 25 => ['infraspecies', 34], 
      35 => ['author_word', 42], 44 => ['author_word', 48], 
      49 => ['author_word', 52], 53 => ['year', 57] })
    sn = 'Cassytha peninsularis J. Z. Weber var. flindersii'
    expect(canonical(sn)).to eq 'Cassytha peninsularis flindersii'
    sn = 'Prunus armeniaca convar. budae (Pénzes) Soó'

    expect(canonical(sn)).to eq 'Prunus armeniaca budae'
    sn = 'Polypodium pectinatum L. f. typica Rosenst.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum typica'
    # might get confused with forma vs filius
    sn = 'Polypodium pectinatum L.f. typica Rosenst.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum typica'
    sn = 'Polypodium pectinatum (L.) f. typica Rosenst.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum typica'
    sn = 'Polypodium pectinatum L. f., Rosenst.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum'
    sn = 'Polypodium pectinatum L. f.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum'
    sn = 'Polypodium pectinatum (L. f.) typica Rosent.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum typica'
    sn = 'Polypodium pectinatum L. f. thisisjunk Rosent.'
    expect(canonical(sn)).to eq 'Polypodium pectinatum thisisjunk'
  end

  it 'parsex unknown original authors (auct.)/(hort.)/(?)' do
    sn = 'Tragacantha leporina (?) Kuntze'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Tragacantha leporina (?) Kuntze'
    expect(details(sn)).to eq [{ genus: { string: 'Tragacantha' }, 
      species: { string: 'leporina', authorship: '(?) Kuntze', 
      combinationAuthorTeam: { authorTeam: 'Kuntze', author: ['Kuntze'] }, 
      basionymAuthorTeam: { authorTeam: '(?)', author: ['?'] } } }]
    sn = 'Lachenalia tricolor var. nelsonii (auct.) Baker'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Lachenalia tricolor var. nelsonii (auct.) Baker'
    expect(details(sn)).to eq [{ genus: { string: 'Lachenalia' }, 
      species: { string: 'tricolor' }, infraspecies: [{ string: 'nelsonii', 
      rank: 'var.', authorship: '(auct.) Baker', 
      combinationAuthorTeam: { authorTeam: 'Baker', 
      author: ['Baker'] }, basionymAuthorTeam: 
      { authorTeam: 'auct.', author: ['unknown'] } }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 10], 11 => ['species', 19], 
      20 => ['infraspecific_type', 24], 25 => ['infraspecies', 33], 
      35 => ['unknown_author', 40], 42 => ['author_word', 47] })
  end

  it 'parses unknown authors auct./anon./hort./ht.' do
    sn = 'Puya acris ht.'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 4], 5 => ['species', 10], 
      11 => ['unknown_author', 14] })
  end

  it 'parses normal names with hort or anon in them' do
    sn = 'Mus musculus hortulanus'
    expect(parse(sn)).to_not be_nil
    expect(pos(sn)).to eq({ 0 => ['genus', 3], 4 => ['species', 12], 
      13 => ['infraspecies', 23] })
  end

  it 'parses real world examples' do
    sn = 'Stagonospora polyspora M.T. Lucas & Sousa da Câmara 1934'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).
      to eq 'Stagonospora polyspora M.T. Lucas & Sousa da Câmara 1934'
    expect(details(sn)).to eq [{ genus: { string: 'Stagonospora' }, 
      species: { string: 'polyspora', 
      authorship: 'M.T. Lucas & Sousa da Câmara 1934', basionymAuthorTeam: 
      { authorTeam: 'M.T. Lucas & Sousa da Câmara', 
      author: ['M.T. Lucas', 'Sousa da Câmara'], year: '1934'} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 22], 
                            23 => ['author_word', 27], 28 => ['author_word', 33], 
                            36 => ['author_word', 41], 42 => ['author_word', 44], 
                            45 => ['author_word', 51], 52 => ['year', 56] })
    expect(parse('Cladoniicola staurospora Diederich, '\
      'van den Boom & Aptroot 2001')).to_not be_nil
    sn = 'Yarrowia lipolytica var. lipolytica (Wick., Kurtzman & E.A. Herrm.) '\
      'Van der Walt & Arx 1981'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Yarrowia lipolytica var. lipolytica '\
      '(Wick., Kurtzman & E.A. Herrm.) Van der Walt & Arx 1981'
    expect(pos(sn)).to eq({ 0 => ['genus', 8], 9 => ['species', 19], 
      20 => ['infraspecific_type', 24], 25 => ['infraspecies', 35], 
      37 => ['author_word', 42], 44 => ['author_word', 52], 
      55 => ['author_word', 59], 60 => ['author_word', 66], 
      68 => ['author_word', 71], 72 => ['author_word', 75], 
      76 => ['author_word', 80], 83 => ['author_word', 86], 
      87 => ['year', 91] })
    expect(parse('Physalospora rubiginosa (Fr.) anon.')).to_not be_nil
    expect(parse('Pleurotus ëous (Berk.) Sacc. 1887')).to_not be_nil
    expect(parse('Lecanora wetmorei Śliwa 2004')).to_not be_nil
    #   valid
    #   infraspecific
    expect(parse('Calicium furfuraceum * furfuraceum (L.) Pers. 1797')).
      to_not be_nil
    expect(parse('Exobasidium vaccinii ** andromedae (P. Karst.) '\
      'P. Karst. 1882')).to_not be_nil
    expect(parse('Urceolaria scruposa **** clausa Flot. 1849')).to_not be_nil
    expect(parse('Cortinarius angulatus B gracilescens Fr. 1838')).to_not be_nil
    expect(parse('Cyathicula scelobelonium')).to_not be_nil
    #   single quote that did not show
    #    parse('Phytophthora hedraiandra De Cock & Man in ?t Veld 2004'
    #   Phthora vastatrix d?Hérelle 1909
    #   author is exception
    sn = 'Tuber liui A S. Xu 1999'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Tuber' }, 
      species: { string: 'liui', authorship: 'A S. Xu 1999', 
      basionymAuthorTeam: { authorTeam: 'A S. Xu',
      author: ['A S. Xu'], year: '1999'} } }]
    expect(parse('Xylaria potentillae A S. Xu')).to_not be_nil
    expect(parse('Agaricus squamula Berk. & M.A. Curtis 1860')).to_not be_nil
    expect(parse('Peltula coriacea Büdel, Henssen & Wessels 1986')).
      to_not be_nil
    #had to add no dot rule for trinomials without a rank to make it to work
    sn = 'Saccharomyces drosophilae anon.'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Saccharomyces' }, 
      species: { string: 'drosophilae', authorship: 'anon.', 
      basionymAuthorTeam: { authorTeam: 'anon.', author: ['unknown']} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 13], 
                            14 => ['species', 25], 
                            26 => ['unknown_author', 31] })
    sn = 'Abacetus laevicollis de Chaudoir, 1869'
    expect(parse(sn)).to_not be_nil
    expect(canonical(sn)).to eq 'Abacetus laevicollis'
    sn = 'Gastrosericus eremorum van Beaumont 1955'
    expect(canonical(sn)).to eq 'Gastrosericus eremorum'
    sn = 'Gastrosericus eremorum von Beaumont 1955'
    expect(canonical(sn)).to eq 'Gastrosericus eremorum'
    sn = 'Cypraeovula (Luponia) amphithales perdentata'
    expect(canonical(sn)).to eq 'Cypraeovula amphithales perdentata'
    expect(details(sn)).to eq [{ genus: { string: 'Cypraeovula' }, 
      infragenus: { string: 'Luponia'}, species: { string: 'amphithales'}, 
      infraspecies: [{ string: 'perdentata', rank: 'n/a'}]}]
    sn = 'Polyrhachis orsyllus nat musculus Forel 1901'
    expect(canonical(sn)).to eq 'Polyrhachis orsyllus musculus'
    sn = 'Latrodectus 13-guttatus Thorell, 1875'
    expect(canonical(sn)).to eq 'Latrodectus tredecguttatus'
    expect(value(sn)).to eq 'Latrodectus tredecguttatus Thorell 1875'
    sn = 'Latrodectus 3-guttatus Thorell, 1875'
    expect(canonical(sn)).to eq 'Latrodectus triguttatus'
    expect(value(sn)).to eq 'Latrodectus triguttatus Thorell 1875'
    sn = 'Balaninus c-album Schönherr, CJ., 1836'
    expect(canonical(sn)).to eq 'Balaninus c-album'
  end

  it 'parses name with morph.' do
    sn = 'Callideriphus flavicollis morph. reductus Fuchs 1961'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).
      to eq 'Callideriphus flavicollis morph. reductus Fuchs 1961'
    expect(canonical(sn)).to eq 'Callideriphus flavicollis reductus'
    expect(details(sn)).to eq [{ genus: { string: 'Callideriphus' }, 
      species: { string: 'flavicollis'}, infraspecies: [{ string: 'reductus', 
      rank: 'morph.', authorship: 'Fuchs 1961', basionymAuthorTeam: 
      { authorTeam: 'Fuchs', author: ['Fuchs'], year: '1961'} }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 13], 14 => ['species', 25], 
                            26 => ['infraspecific_type', 32], 
                            33 => ['infraspecies', 41], 
                            42 => ['author_word', 47], 48 => ['year', 52] })
  end


  it 'parses name with forma/fo./form./f.' do
    sn = 'Caulerpa cupressoides forma nuda'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Caulerpa cupressoides forma nuda'
    expect(canonical(sn)).to eq 'Caulerpa cupressoides nuda'
    expect(details(sn)).to eq [{ genus: { string: 'Caulerpa' }, 
      species: { string: 'cupressoides'}, 
      infraspecies: [{ string: 'nuda', rank: 'forma'}]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 8], 9 => ['species', 21], 
                            22 => ['infraspecific_type', 27], 
                            28 => ['infraspecies', 32] })
    sn = 'Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó'
    expect(parse(sn)).to_not be_nil
    expect(value('Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó')).
      to eq 'Chlorocyperus glaber form. fasciculariforme (Lojac.) Soó'
    expect(canonical(sn)).to eq 'Chlorocyperus glaber fasciculariforme'
    expect(details(sn)).to eq [{ genus: { string: 'Chlorocyperus' }, 
      species: { string: 'glaber'}, infraspecies: 
      [{ string: 'fasciculariforme', rank: 'form.', 
      authorship: '(Lojac.) Soó', combinationAuthorTeam: { authorTeam: 'Soó', 
      author: ['Soó']}, basionymAuthorTeam: { authorTeam: 'Lojac.', 
      author: ['Lojac.']} }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 13], 14 => ['species', 20], 
                            21 => ['infraspecific_type', 26], 
                            27 => ['infraspecies', 43], 
                            45 => ['author_word', 51], 
                            53 => ['author_word', 56] })
    sn = 'Bambusa nana Roxb. fo. alphonse-karri (Mitford ex Satow) '\
      'Makino ex Shiros.'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Bambusa nana Roxb. fo. alphonse-karri '\
      '(Mitford ex Satow) Makino ex Shiros.'
    expect(canonical(sn)).to eq 'Bambusa nana alphonse-karri'
    expect(details(sn)).to eq [{ genus: { string: 'Bambusa' }, 
      species: { string: 'nana', authorship: 'Roxb.', basionymAuthorTeam: 
      { authorTeam: 'Roxb.', author: ['Roxb.']} }, 
      infraspecies: [{ string: 'alphonse-karri', 
      rank: 'fo.', authorship: '(Mitford ex Satow) Makino ex Shiros.', 
      combinationAuthorTeam: { authorTeam: 'Makino', 
      author: ['Makino'], exAuthorTeam: { authorTeam: 'Shiros.', 
      author: ['Shiros.']} }, basionymAuthorTeam: { authorTeam: 'Mitford', 
      author: ['Mitford'], exAuthorTeam: { authorTeam: 'Satow', 
      author: ['Satow']} } }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 7], 8 => ['species', 12], 
      13 => ['author_word', 18], 19 => ['infraspecific_type', 22], 
      23 => ['infraspecies', 37], 39 => ['author_word', 46], 
      50 => ['author_word', 55], 57 => ['author_word', 63], 
      67 => ['author_word', 74] })
    sn = '   Sphaerotheca    fuliginea     f.    dahliae    Movss.   1967    '
    sn = 'Sphaerotheca    fuliginea    f.     dahliae    Movss.     1967'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Sphaerotheca fuliginea f. dahliae Movss. 1967'
    expect(canonical(sn)).to eq 'Sphaerotheca fuliginea dahliae'
    expect(details(sn)).to eq  [{ genus: { string: 'Sphaerotheca' }, 
      species: { string: 'fuliginea'}, infraspecies: 
      [{ string: 'dahliae', rank: 'f.', authorship: 'Movss.     1967', 
      basionymAuthorTeam: { authorTeam: 'Movss.', 
      author: ['Movss.'], year: '1967'} }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 16 => ['species', 25], 
      29 => ['infraspecific_type', 31], 36 => ['infraspecies', 43], 
      47 => ['author_word', 53], 58 => ['year', 62] })
    expect(parse('Polypodium vulgare nothosubsp. mantoniae (Rothm.) Schidlay')).
      to_not be_nil
  end

  it 'parses name with several subspecies names' do
  # NOT BOTANICAL CODE BUT NOT INFREQUENT'
    sn = 'Hydnellum scrobiculatum var. zonatum f. '\
      'parvum (Banker) D. Hall & D.E. Stuntz 1972'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Hydnellum scrobiculatum var. zonatum f. '\
      'parvum (Banker) D. Hall & D.E. Stuntz 1972'
    expect(details(sn)).to eq  [{ genus: { string: 'Hydnellum' }, species: 
      { string: 'scrobiculatum'}, infraspecies: [{ string: 'zonatum', 
      rank: 'var.'}, { string: 'parvum', rank: 'f.', 
      authorship: '(Banker) D. Hall & D.E. Stuntz 1972', 
      combinationAuthorTeam: { authorTeam: 'D. Hall & D.E. Stuntz', 
      author: ['D. Hall', 'D.E. Stuntz'], year: '1972'}, 
      basionymAuthorTeam: { authorTeam: 'Banker', author: ['Banker']} }]}]
    expect(pos(sn)).to eq({ 0 => ['genus', 9], 10 => ['species', 23], 
      24 => ['infraspecific_type', 28], 29 => ['infraspecies', 36], 
      37 => ['infraspecific_type', 39], 40 => ['infraspecies', 46], 
      48 => ['author_word', 54], 56 => ['author_word', 58], 
      59 => ['author_word', 63], 66 => ['author_word', 70], 
      71 => ['author_word', 77], 78 => ['year', 82] })
    expect(parse('Senecio fuchsii C.C.Gmel. subsp. fuchsii var. '\
      'expansus (Boiss. & Heldr.) Hayek')).to_not be_nil
    expect(parse('Senecio fuchsii C.C.Gmel. subsp. fuchsii var. fuchsii')).
      to_not be_nil
  end


  it 'parses status BOTANICAL RARE' do
    #it is always latin abbrev often 2 words
    sn = 'Arthopyrenia hyalospora (Nyl.) R.C. Harris comb. nov.'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Arthopyrenia hyalospora (Nyl.) '\
      'R.C. Harris comb. nov.'
    expect(canonical(sn)).to eq 'Arthopyrenia hyalospora'
    expect(details(sn)).to eq  [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora', authorship: '(Nyl.) R.C. Harris', 
      combinationAuthorTeam: { authorTeam: 'R.C. Harris', 
      author: ['R.C. Harris']}, basionymAuthorTeam: { authorTeam: 'Nyl.', 
      author: ['Nyl.']} }, status: 'comb. nov.'}]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23], 
      25 => ['author_word', 29], 31 => ['author_word', 35], 
      36 => ['author_word', 42] })
  end

  it 'parses revised (ex) names' do
    #invalidly published
    sn = 'Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).
      to eq 'Arthopyrenia hyalospora (Nyl. ex Banker) R.C. Harris'
    expect(canonical(sn)).to eq 'Arthopyrenia hyalospora'
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora', 
      authorship: '(Nyl. ex Banker) R.C. Harris', combinationAuthorTeam: 
      { authorTeam: 'R.C. Harris', author: ['R.C. Harris']}, 
      basionymAuthorTeam: { authorTeam: 'Nyl.', author: ['Nyl.'], 
      exAuthorTeam: { authorTeam: 'Banker', author: ['Banker']} } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23], 
      25 => ['author_word', 29], 33 => ['author_word', 39], 
      41 => ['author_word', 45], 46 => ['author_word', 52] })
    sn = 'Arthopyrenia hyalospora Nyl. ex Banker'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora', authorship: 'Nyl. ex Banker', 
      basionymAuthorTeam: { authorTeam: 'Nyl.', author: ['Nyl.'], 
      exAuthorTeam: { authorTeam: 'Banker', author: ['Banker']} } } }]
    sn = 'Glomopsis lonicerae Peck ex C.J. Gould 1945'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Glomopsis' }, 
      species: { string: 'lonicerae', authorship: 'Peck ex C.J. Gould 1945', 
      basionymAuthorTeam: { authorTeam: 'Peck', author: ['Peck'], 
      exAuthorTeam: { authorTeam: 'C.J. Gould', author: ['C.J. Gould'], 
      year: '1945'} } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 9], 10 => ['species', 19], 
      20 => ['author_word', 24], 28 => ['author_word', 32], 
      33 => ['author_word', 38], 39 => ['year', 43] })
    expect(parse('Acanthobasidium delicatum (Wakef.) Oberw. ex Jülich 1979')).
      to_not be_nil
    sn = 'Mycosphaerella eryngii (Fr. ex Duby) Johanson ex Oudem. 1897'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Mycosphaerella' }, 
      species: { string: 'eryngii', 
      authorship: '(Fr. ex Duby) Johanson ex Oudem. 1897', 
      combinationAuthorTeam: { authorTeam: 'Johanson', author: ['Johanson'], 
      exAuthorTeam: { authorTeam: 'Oudem.', author: ['Oudem.'], year: '1897'} }, 
      basionymAuthorTeam: { authorTeam: 'Fr.', author: ['Fr.'], 
      exAuthorTeam: { authorTeam: 'Duby', author: ['Duby']} } } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 14], 15 => ['species', 22], 
      24 => ['author_word', 27], 31 => ['author_word', 35], 
      37 => ['author_word', 45], 49 => ['author_word', 55], 
      56 => ['year', 60] })
    #invalid but happens
    expect(parse('Mycosphaerella eryngii (Fr. Duby) ex Oudem. 1897')).
      to_not be_nil
    expect(parse('Mycosphaerella eryngii (Fr.ex Duby) ex Oudem. 1897')).
      to_not be_nil
    sn = 'Salmonella werahensis (Castellani) Hauduroy and Ehringer '\
      'in Hauduroy 1937'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Salmonella' }, 
      species: { string: 'werahensis', 
      authorship: '(Castellani) Hauduroy and Ehringer in Hauduroy 1937', 
      combinationAuthorTeam: { authorTeam: 'Hauduroy and Ehringer', 
      author: ['Hauduroy', 'Ehringer'], exAuthorTeam: { 
      authorTeam: 'Hauduroy', author: ['Hauduroy'], year: '1937'} }, 
      basionymAuthorTeam: { authorTeam: 'Castellani', 
      author: ['Castellani']} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 10], 11 => ['species', 21], 
      23 => ['author_word', 33], 35 => ['author_word', 43], 
      48 => ['author_word', 56], 60 => ['author_word', 68], 
      69 => ['year', 73] })
  end

  it 'parses named hybrids' do
    [
      ['×Agropogon P. Fourn. 1934', [{ uninomial: { string: 'Agropogon', 
        authorship: 'P. Fourn. 1934', basionymAuthorTeam: 
        { authorTeam: 'P. Fourn.', author: ['P. Fourn.'], year: '1934' } } }]],
      ['xAgropogon P. Fourn.', [{ uninomial: { string: 'Agropogon', 
        authorship: 'P. Fourn.', basionymAuthorTeam: { authorTeam: 'P. Fourn.', 
        author: ['P. Fourn.'] } } }]],
      ['XAgropogon P.Fourn.', [{ uninomial: { string: 'Agropogon', 
        authorship: 'P.Fourn.', basionymAuthorTeam: { authorTeam: 'P.Fourn.', 
        author: ['P.Fourn.'] } } }]],
      ['× Agropogon', [{ uninomial: { string: 'Agropogon' } }]],
      ['x Agropogon', [{ uninomial: { string: 'Agropogon' } }]],
      ['X Agropogon', [{ uninomial: { string: 'Agropogon' } }]],
      ['X Cupressocyparis leylandii', [{ genus: { string: 'Cupressocyparis' }, 
        species: { string: 'leylandii'} }]],
      ['×Heucherella tiarelloides', [{ genus: { string: 'Heucherella' }, 
        species: { string: 'tiarelloides'} }]],
      ['xHeucherella tiarelloides', [{ genus: { string: 'Heucherella' }, 
        species: { string: 'tiarelloides'} }]],
      ['x Heucherella tiarelloides', [{ genus: { string: 'Heucherella' }, 
        species: { string: 'tiarelloides'} }]],
      ['×Agropogon littoralis (Sm.) C. E. Hubb. 1946', [{ genus: 
        { string: 'Agropogon' }, species: { string: 'littoralis', 
        authorship: '(Sm.) C. E. Hubb. 1946', combinationAuthorTeam: 
        { authorTeam: 'C. E. Hubb.', author: ['C. E. Hubb.'], year: '1946'}, 
        basionymAuthorTeam: { authorTeam: 'Sm.', author: ['Sm.']} } }]]
    ].each do |res|
      expect(parse(res[0])).to_not be_nil
      expect(parse(res[0]).hybrid).to eq true
      expect(details(res[0])).to eq res[1]
    end
   [
    ['Asplenium X inexpectatum (E.L. Braun 1940) Morton (1956)',
     [{ genus: { string: 'Asplenium' }, species: { string: 'inexpectatum', 
     authorship: '(E.L. Braun 1940) Morton (1956)', combinationAuthorTeam: 
     { authorTeam: 'Morton', author: ['Morton'], year: '1956'}, 
     basionymAuthorTeam: { authorTeam: 'E.L. Braun', author: ['E.L. Braun'], 
     year: '1940'} } }]],
    ['Mentha ×smithiana R. A. Graham 1949',[{ genus: { string: 'Mentha' }, 
      species: { string: 'smithiana', authorship: 'R. A. Graham 1949', 
      basionymAuthorTeam: { authorTeam: 'R. A. Graham', 
      author: ['R. A. Graham'], year: '1949'} } }]],
    ['Salix ×capreola Andersson (1867)',[{ genus: { string: 'Salix' }, 
      species: { string: 'capreola', authorship: 'Andersson (1867)', 
      basionymAuthorTeam: { authorTeam: 'Andersson', author: ['Andersson'], 
      year: '1867'} } }]],
    ['Salix x capreola Andersson',[{ genus: { string: 'Salix' }, 
      species: { string: 'capreola', authorship: 'Andersson', 
      basionymAuthorTeam: { authorTeam: 'Andersson', 
      author: ['Andersson']} } }]]
   ].each do |res|
      expect(parse(res[0])).to_not be_nil
      expect(parse(res[0]).hybrid).to  eq true
      expect(details(res[0])).to eq res[1]
   end
   sn = 'Rosa alpina x pomifera'
   expect(canonical(sn)).to eq 'Rosa alpina × pomifera'
   expect(parse(sn).details).to eq [{ genus: { string: 'Rosa' }, 
     species: { string: 'alpina'} }, { species: { string: 'pomifera'}, 
     genus: { string: 'Rosa'} }]
  end

  it 'parses hybrid combination' do
    sn = 'Arthopyrenia hyalospora X Hydnellum scrobiculatum'
    expect(parse(sn)).to_not be_nil
    expect(parse(sn).hybrid).to eq true
    expect(value(sn)).
      to eq "Arthopyrenia hyalospora \303\227 Hydnellum scrobiculatum"
    expect(canonical(sn)).
      to eq 'Arthopyrenia hyalospora × Hydnellum scrobiculatum'
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora'} }, { genus: { string: 'Hydnellum'}, 
      species: { string: 'scrobiculatum'} }]
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23], 
      26 => ['genus', 35], 36 => ['species', 49] })
    sn = 'Arthopyrenia hyalospora (Banker) D. Hall X Hydnellum '\
      'scrobiculatum D.E. Stuntz'
    expect(parse(sn)).to_not be_nil
    expect(parse(sn).hybrid).to eq true
    expect(value(sn)).to eq "Arthopyrenia hyalospora (Banker) "\
      "D. Hall \303\227 Hydnellum scrobiculatum D.E. Stuntz"
    expect(canonical(sn)).
      to eq 'Arthopyrenia hyalospora × Hydnellum scrobiculatum'
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23], 
      25 => ['author_word', 31], 33 => ['author_word', 35], 
      36 => ['author_word', 40], 43 => ['genus', 52], 
      53 => ['species', 66], 67 => ['author_word', 71], 
      72 => ['author_word', 78] })
    expect(value('Arthopyrenia hyalospora X')).
      to eq "Arthopyrenia hyalospora \303\227 ?"
    sn = 'Arthopyrenia hyalospora x'
    expect(parse(sn)).to_not be_nil
    expect(parse(sn).hybrid).to eq true
    expect(canonical(sn)).to eq 'Arthopyrenia hyalospora'
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora'} }, '?']
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23] })
    sn = 'Arthopyrenia hyalospora × ?'
    expect(parse(sn)).to_not be_nil
    expect(parse(sn).hybrid).to eq true
    expect(details(sn)).to eq [{ genus: { string: 'Arthopyrenia' }, 
      species: { string: 'hyalospora'} }, '?']
    expect(pos(sn)).to eq({ 0 => ['genus', 12], 13 => ['species', 23] })
  end

  it 'parses names with taxon concept' do
    sn = 'Stenometope laevissimus sec. Eschmeyer 2004'
    expect(details(sn)).to eq [{ genus: { string: 'Stenometope' }, 
      species: { string: 'laevissimus'}, taxon_concept: 
      { authorship: 'Eschmeyer 2004', 
      basionymAuthorTeam: { authorTeam: 'Eschmeyer', 
      author: ['Eschmeyer'], year: '2004'} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 11], 12 => ['species', 23], 
                            29 => ['author_word', 38], 39 => ['year', 43] })
    sn = 'Stenometope laevissimus Bibron 1855 sec. Eschmeyer 2004'
    expect(parse(sn)).to_not be_nil
    expect(details(sn)).to eq [{ genus: { string: 'Stenometope' }, 
      species: { string: 'laevissimus', authorship: 'Bibron 1855', 
      basionymAuthorTeam: { authorTeam: 'Bibron', author: ['Bibron'], 
      year: '1855'} }, taxon_concept: { authorship: 'Eschmeyer 2004', 
      basionymAuthorTeam: { authorTeam: 'Eschmeyer', 
      author: ['Eschmeyer'], year: '2004'} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 11], 12 => ['species', 23], 
      24 => ['author_word', 30], 31 => ['year', 35], 
      41 => ['author_word', 50], 51 => ['year', 55] })
  end

  it 'parses names with spaces inconsistencies' do
    expect(parse('   Asplenium X inexpectatum (E.L. Braun 1940) '\
      'Morton (1956)   ')).to_not be_nil
  end

  it 'parses names with any number of spaces' do
    sn = 'Trematosphaeria phaeospora (E. Müll.)'\
      '         L.             Holm 1957'
    expect(parse(sn)).to_not be_nil
    expect(value(sn)).to eq 'Trematosphaeria phaeospora (E. Müll.) L. Holm 1957'
    expect(canonical(sn)).to eq 'Trematosphaeria phaeospora'
    expect(details(sn)).to eq [{ genus: { string: 'Trematosphaeria' }, 
      species: { string: 'phaeospora', authorship: '(E. Müll.)         '\
      'L.             Holm 1957', 
      combinationAuthorTeam: { authorTeam: 'L.             Holm', 
      author: ['L. Holm'], year: '1957'}, 
      basionymAuthorTeam: { authorTeam: 'E. Müll.', author: ['E. Müll.']} } }]
    expect(pos(sn)).to eq({ 0 => ['genus', 15], 16 => ['species', 26], 
      28 => ['author_word', 30], 31 => ['author_word', 36], 
      46 => ['author_word', 48], 61 => ['author_word', 65], 
      66 => ['year', 70] })
  end

  it 'does not parse serveral authors groups with several years NOT CORRECT' do
    expect(parse('Pseudocercospora dendrobii (H.C. Burnett 1883) '\
      '(Leight.) (Movss. 1967) U. Braun & Crous 2003')).to be_nil
  end

  it 'does not parse unallowed utf-8 chars in name part' do
    expect(parse('Érematosphaeria phaespora')).to be_nil
    expect(parse('Trematosphaeria phaeáapora')).to be_nil
    expect(parse('Trematоsphaeria phaeaapora')).to be_nil #cyrillic o
  end

  it 'parses new stuff' do
    sn = 'Nesticus quelpartensis Paik & Namkung, in Paik, '\
      'Yaginuma & Namkung, 1969'
    expect(details(sn)).to eq [{ genus: { string: 'Nesticus' }, 
      species: { string: 'quelpartensis', 
      authorship: 'Paik & Namkung, in Paik, Yaginuma & Namkung, 1969', 
      basionymAuthorTeam: { authorTeam: 'Paik & Namkung', 
      author: ['Paik', 'Namkung'], exAuthorTeam: 
      { authorTeam: 'Paik, Yaginuma & Namkung', 
      author: ['Paik', 'Yaginuma', 'Namkung'], year: '1969'} } } }]
    expect(parse('Dipoena yoshidai Ono, in Ono et al., 1991')).to_not be_nil
    sn = 'Latrodectus mactans bishopi Kaston, 1938'
    expect(details(sn)).to eq [{ genus: { string: 'Latrodectus' }, 
      species: { string: 'mactans'}, infraspecies: [{ string: 'bishopi', 
      rank: 'n/a', authorship: 'Kaston, 1938', 
      basionymAuthorTeam: { authorTeam: 'Kaston', 
      author: ['Kaston'], year: '1938'} }]}]
    #have to figure out black lists for this one
    sn = 'Thiobacillus x Parker and Prisk 1953' 
    sn = 'Bacille de Plaut, Kritchevsky and Séguin 1921'
    expect(details(sn)).to eq [{ uninomial: { string: 'Bacille', 
      authorship: 'de Plaut, Kritchevsky and Séguin 1921', 
      basionymAuthorTeam: { authorTeam: 'de Plaut, Kritchevsky and Séguin', 
      author: ['de Plaut', 'Kritchevsky', 'Séguin'], year: '1921' } } }]
    sn = 'Araneus van bruysseli Petrunkevitch, 1911'
    expect(details(sn)).to eq [{ genus: { string: 'Araneus' }, 
      species: { string: 'van'}, infraspecies: [{ string: 'bruysseli', 
      rank: 'n/a', authorship: 'Petrunkevitch, 1911', 
      basionymAuthorTeam: { authorTeam: 'Petrunkevitch', 
      author: ['Petrunkevitch'], year: '1911'} }]}]
    sn = 'Sapromyces laidlawi ab Sabin 1941'
    expect(details(sn)).to eq [{ genus: { string: 'Sapromyces' }, 
      species: { string: 'laidlawi', authorship: 'ab Sabin 1941', 
      basionymAuthorTeam: { authorTeam: 'ab Sabin', author: ['ab Sabin'], 
      year: '1941'} } }]
    sn = 'Nocardia rugosa di Marco and Spalla 1957'
    expect(details(sn)).to eq [{ genus: { string: 'Nocardia' }, 
      species: { string: 'rugosa', authorship: 'di Marco and Spalla 1957', 
      basionymAuthorTeam: { authorTeam: 'di Marco and Spalla', 
      author: ['di Marco', 'Spalla'], year: '1957'} } }]
    sn = 'Flexibacter elegans Lewin 1969 non Soriano 1945'
    expect(details(sn)).to eq [{ genus: { string: 'Flexibacter' }, 
      species: { string: 'elegans', authorship: 'Lewin 1969 non Soriano 1945', 
      basionymAuthorTeam: { authorTeam: 'Lewin', author: ['Lewin'], 
      year: '1969'} } }]
    sn = 'Flexibacter elegans Soriano 1945, non Lewin 1969'
    expect(details(sn)).to eq [{ genus: { string: 'Flexibacter' }, 
      species: { string: 'elegans', authorship: 'Soriano 1945, non Lewin 1969', 
      basionymAuthorTeam: { authorTeam: 'Soriano', author: ['Soriano'], 
      year: '1945'} } }]
    sn = 'Schottera nicaeënsis (J.V. Lamouroux ex Duby) Guiry & Hollenberg'
    expect(details(sn)).to eq [{ genus: { string: 'Schottera' }, 
      species: { string: 'nicaeensis', 
      authorship: '(J.V. Lamouroux ex Duby) Guiry & Hollenberg', 
      combinationAuthorTeam: { authorTeam: 'Guiry & Hollenberg', 
      author: ['Guiry', 'Hollenberg']}, basionymAuthorTeam: 
      { authorTeam: 'J.V. Lamouroux', author: ['J.V. Lamouroux'], 
      exAuthorTeam: { authorTeam: 'Duby', author: ['Duby']} } } }]
    sn = 'Deschampsia cespitosa ssp pumila'
    expect(details(sn)).to eq [{ genus: { string: 'Deschampsia' }, 
      species: { string: 'cespitosa'}, 
      infraspecies: [{ string: 'pumila', rank: 'ssp'}]}]
  end

  # Combination genus names merges without dash or capital letter
  it 'parses hybrid names with capitalized second name in genus' do
    # (botanical code error)
    sn = 'Anacampti-Platanthera P. Fourn.'
    expect(parse(sn)).to_not be_nil
    expect(canonical(sn)).to eq 'Anacamptiplatanthera'
    sn = 'Anacampti-Platanthera vulgaris P. Fourn.'
    expect(parse(sn)).to_not be_nil
    expect(canonical(sn)).to eq 'Anacamptiplatanthera vulgaris'
  end

  it 'parses genus names starting with uppercase letters AE OE' do
    sn = 'AEmona separata Broun 1921'
    expect(canonical(sn)).to eq 'Aemona separata'
    sn = 'OEmona simplex White, 1855'
    expect(canonical(sn)).to eq 'Oemona simplex'
  end
  #'Arthrosamanea eriorhachis (Harms & sine ref. ) Aubrév.'
  # -- ignore & sine ref. (means without reference)

=begin
  new stuff

   sn = 'Orchidaceae × Asconopsis hort.'
   expect(canonical(sn)).to eq 'Orchidaceae x Asconopsis'
   sn
   Tamiops swinhoei near hainanus|Tamiops swinhoei near hainanus
   Conus textile form archiepiscopus|Conus textile form archiepiscopus|
   Crypticus pseudosericeus ssp. olivieri Desbrochers des \
     Loges,1881|Crypticus pseudosericeus olivieri des
   Solanum nigrum subsp nigrum|Solanum nigrum subsp nigrum
   Protoglossus taeniatum author unknown|Protoglossus taeniatum author unknown
   Dupontiella (S. ?) bicolor|Dupontiella|
=end
end
