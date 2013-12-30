require 'spec_helper'

describe Biodiversity do
  describe '.version' do
    it 'returns version' do
      expect(subject.version).to match /^\d+\.\d+\.\d+/
    end

    it 'is the same as Biodiversity::Version constant' do
      expect(subject.version).to eq Biodiversity::VERSION
    end
  end
end
