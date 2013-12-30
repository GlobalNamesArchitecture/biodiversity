require_relative '../spec_helper'

describe LsidResolver do
  describe '.resolve' do
    let(:lsid) { 'urn:lsid:ubio.org:classificationbank:2232671' }

    it 'resolves lsid using tdwg service' do
      stub_request(:get,
                   %r|#{Biodiversity::LSID_RESOLVER_URL + lsid}|).to_return do
        { body: File.read(File.expand_path('../../files/lsid.xml', __FILE__)) }
      end
      expect(LsidResolver.resolve lsid).
             to match %r|<dc:title>Pternistis Wagler 1832</dc:title>|
    end
  end

end
