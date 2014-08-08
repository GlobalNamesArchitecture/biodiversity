# encoding: UTF-8
require_relative '../spec_helper'

describe ScientificNameCanonical do
  before(:all) do
    set_parser(ScientificNameCanonicalParser.new)
  end

  it 'parses names with valid name part and unparseable rest' do
    [
      ['Morea ssjjlajajaj324$33 234243242','Morea', 
       [{ uninomial: { string: 'Morea' }}], { 0 => ['uninomial', 5]}],
      ['Morea (Morea) Burt 2342343242 23424322342 23424234', 
       'Morea (Morea)', [{ genus: { string: 'Morea' }, 
                          infragenus: { string: 'Morea' }}], 
       { 0 => ['genus', 5], 7 => ['infragenus', 12] }],      
      ['Morea (Morea) burtius 2342343242 23424322342 23424234', 
       'Morea (Morea) burtius', [{ genus: { string: 'Morea' }, 
                                  infragenus: { string: 'Morea' }, 
                                  species: { string: 'burtius' }}], 
       { 0 => ['genus', 5], 7 => ['infragenus', 12], 14 => ['species', 21] }],
      ['Moraea spathulata ( (L. f. Klatt','Moraea spathulata',
       [{ genus: { string: 'Moraea' }, species: { string: 'spathulata'}}], 
       { 0 => ['genus', 6], 7 => ['species', 17] } ],
      ['Verpericola megasoma ""Dall" Pils.','Verpericola megasoma',
       [{ genus: { string: 'Verpericola' }, 
         species: { string: 'megasoma'}}], 
       { 0 => ['genus', 11], 12 => ['species', 20] }] 
    ].each do |n|
      expect(parse(n[0])).not_to be_nil
      expect(value(n[0])).to eq n[1]
      expect(details(n[0])).to eq n[2]
      expect(pos(n[0])).to eq n[3]
      expect(parse(n[0]).hybrid).to be false
    end
  end  
  
end
