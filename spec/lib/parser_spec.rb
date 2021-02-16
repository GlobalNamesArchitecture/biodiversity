# frozen_string_literal: true

# s frozen_string_literal: true

describe Biodiversity::Parser do
  describe('parse') do
    it 'parses name in simple format' do
      parsed = subject.parse('Homo sapiens Linn.', true)
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:normalized]).to be_nil
    end

    it 'parsed name in full format' do
      parsed = subject.parse('Homo sapiens  Linn.')
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:normalized]).to eq 'Homo sapiens Linn.'
    end

    it 'gets quality and year correctly in simple form' do
      parsed = subject.parse('Homo sapiens Linn. 1758', true)
      expect(parsed[:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[:year]).to eq '1758'
      expect(parsed[:quality]).to eq '1'
      expect(parsed[:normalized]).to be_nil
    end

    it 'treats newlines as whitespaces' do # Requirement for IPC to work
      parsed = subject.parse("\nHomo\r\nsapiens\nLinn.\r1758\n")
      expect(parsed[:verbatim]).to eq ' Homo sapiens Linn. 1758 '
      expect(parsed[:normalized]).to eq parsed[:verbatim].strip
    end
  end

  describe('parse_ary') do
    it 'parses names in simple format' do
      parsed = subject.parse_ary(['Homo sapiens Linn.', 'Pardosa moesta'], true)
      expect(parsed[0][:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[1][:canonical][:simple]).to eq 'Pardosa moesta'
      expect(parsed[0][:normalized]).to be_nil
    end

    it 'parsed name in full format' do
      parsed = subject.parse_ary(
        ['Homo sapiens  Linn.', 'Tobacco Mosaic Virus']
      )
      expect(parsed[0][:canonical][:simple]).to eq 'Homo sapiens'
      expect(parsed[0][:normalized]).to eq 'Homo sapiens Linn.'
      expect(parsed[1][:parsed]).to be false
      expect(parsed[1][:virus]).to be true
    end

    it 'treats newlines as whitespaces' do # Requirement for IPC to work
      parsed = subject.parse_ary(["\nHomo\r\nsapiens\nLinn.\r1758\n"])
      expect(parsed.length).to eq 1
      parsed = parsed.first
      expect(parsed[:verbatim]).to eq ' Homo sapiens Linn. 1758 '
      expect(parsed[:normalized]).to eq parsed[:verbatim].strip
    end
  end
end
