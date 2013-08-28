require_relative '../spec_helper'

describe LsidResolver do
  it 'should return RFD document from lsid' do
    lsid = 'urn:lsid:ubio.org:classificationbank:2232671'
    stub(LsidResolver).resolve(lsid) {''}
    LsidResolver.resolve(lsid).class.should == String
  end
end
