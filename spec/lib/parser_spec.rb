# frozen_string_literal: true

# s frozen_string_literal: true

describe Biodiversity::Parser do
  describe('parse') do
    it 'parses name in simple form' do
      parsed = subject.parse('Homo sapiens Linn.', simple: true)
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:normalized]).to be_nil
    end

    it 'parsed name in full form' do
      parsed = subject.parse('Homo sapiens  Linn. 1758')
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:normalized]).to eq 'Homo sapiens Linn. 1758'
      expect(parsed[:authorship][:year]).to eq '1758'
      expect(parsed[:words].size).to eq 4
    end

    it 'gets quality and year correctly in simple form' do
      parsed = subject.parse('Homo sapiens Foo & Bar. 1758', simple: true)
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:year]).to eq '1758'
      expect(parsed[:authorship]).to eq 'Foo & Bar. 1758'
      expect(parsed[:quality]).to eq 1
      expect(parsed[:normalized]).to be_nil
    end

    it 'parses botanical cultivars in full form' do
      parsed = subject.parse('Aus bus "White Russian"',
                             simple: false, with_cultivars: true)
      expect(parsed[:canonical][:simple]).to eq 'Aus bus ‘White Russian’'
      expect(parsed[:quality]).to eq 1
    end

    it 'parses botanical cultivars in simple form' do
      parsed = subject.parse('Aus bus "White Russian"',
                             simple: true, with_cultivars: true)
      expect(parsed[:canonical][:simple]).to eq 'Aus bus ‘White Russian’'
      expect(parsed[:quality]).to eq 1
      parsed = subject.parse('Aus bus "White Russian"',
                             simple: true, with_cultivars: false)
      expect(parsed[:canonical][:simple]).to eq 'Aus bus'
      expect(parsed[:quality]).to eq 2
    end
  end

  describe('parse_ary') do
    it 'parses names in simple format' do
      parsed = subject.parse_ary(
        ['Homo sapiens Linn.', 'Pardosa moesta'],
        simple: true
      )
      expect(parsed[0][:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[0][:normalized]).to be_nil

      expect(parsed[1][:canonical][:simple]).to eq 'Pardosa moesta'
    end

    it 'parsed name in full format' do
      parsed = subject.parse_ary(
        ['Homo sapiens  Linn.', 'Tobacco Mosaic Virus']
      )
      expect(parsed[0][:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[0][:normalized]).to eq 'Homo sapiens Linn.'
      expect(parsed[0][:words].size).to eq 3
      expect(parsed[1][:parsed]).to be false
      expect(parsed[1][:virus]).to be true
      expect(parsed[1][:words]).to be_nil
    end
  end
end
