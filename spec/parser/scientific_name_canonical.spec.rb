# encoding: UTF-8
dir = File.dirname("__FILE__")
require File.expand_path(dir + '../../spec/parser/spec_helper')

describe ScientificNameCanonical do
  before(:all) do
    set_parser(ScientificNameCanonicalParser.new)
  end
  
    
  it 'should parse names with valid name part and unparseable rest' do
    [
      ['Morea ssjjlajajaj324$33 234243242','Morea', {:uninomial=>{:epitheton=>"Morea"}}, {0=>["uninomial", 5]}],
      ['Morea (Morea) Burt 2342343242 23424322342 23424234', 'Morea (Morea)', {:genus=>{:epitheton=>"Morea"}, :subgenus=>{:epitheton=>"Morea"}}, {0=>["genus", 5], 7=>["subgenus", 12]}],      
      ['Morea (Morea) burtius 2342343242 23424322342 23424234', 'Morea (Morea) burtius', {:genus=>{:epitheton=>"Morea"}, :subgenus=>{:epitheton=>"Morea"}, :species=>{:epitheton=>"burtius"}}, {0=>["genus", 5], 7=>["subgenus", 12], 14=>["species", 21]}],
      ['Moraea spathulata ( (L. f. Klatt','Moraea spathulata',{:genus=>{:epitheton=>"Moraea"}, :species=>{:epitheton=>"spathulata"}}, {0=>["genus", 6], 7=>["species", 17]} ],
      ['Verpericola megasoma ""Dall" Pils.','Verpericola megasoma',{:genus=>{:epitheton=>"Verpericola"}, :species=>{:epitheton=>"megasoma"}}, {0=>["genus", 11], 12=>["species", 20]}] 
    ].each do |n|
      parse(n[0]).should_not be_nil
      value(n[0]).should == n[1]
      details(n[0]).should == n[2]
      pos(n[0]).should == n[3]
    end
  end  
end