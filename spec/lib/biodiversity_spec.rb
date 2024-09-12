# frozen_string_literal: true

describe Biodiversity do
  describe 'version' do
    it 'returns version of Biodiversity gem' do
      expect(subject.version).to match(/\d+\.\d+\.\d+/)
    end
  end
  describe 'gnparser_version' do
    it 'matches bundled binary version' do
      binary_version = Biodiversity::Parser.parse('')[:parserVersion].match(/\d.*$/).to_s
      expect(subject.gnparser_version).to match("GNparser #{binary_version}")
    end
  end
end
