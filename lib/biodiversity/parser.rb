# encoding: UTF-8
dir = File.dirname(__FILE__)
require File.join(dir, *%w[parser scientific_name_clean])
require File.join(dir, *%w[parser scientific_name_dirty])
require File.join(dir, *%w[parser scientific_name_canonical])
require 'rubygems'
require 'json'

module PreProcessor
  NOTES = /\s+(species\s+group|species\s+complex|group|author)\b.*$/i
  TAXON_CONCEPTS1 = /\s+(sensu\.|sensu|auct\.|auct)\b.*$/i
  TAXON_CONCEPTS2 = /\s+(\(?s\.\s?s\.|\(?s\.\s?l\.|\(?s\.\s?str\.|\(?s\.\s?lat\.|sec\.|sec|near)\b.*$/
  TAXON_CONCEPTS3 = /(,\s*|\s+)(pro parte|p\.\s?p\.)\s*$/i  
  NOMEN_CONCEPTS  = /(,\s*|\s+)(\(?nomen|\(?nom\.|\(?comb\.).*$/i
  LAST_WORD_JUNK  = /(,\s*|\s+)(spp\.|spp|var\.|var|von|van|ined\.|ined|sensu|new|non|nec|nudum|cf\.|cf|sp\.|sp|ssp\.|ssp|subsp|subgen|hybrid|hort\.|hort)\??\s*$/i
  
  def self.clean(a_string)
    [NOTES, TAXON_CONCEPTS1, TAXON_CONCEPTS2, 
     TAXON_CONCEPTS3, NOMEN_CONCEPTS, LAST_WORD_JUNK].each do |i|
      a_string = a_string.gsub(i, '')
    end
    a_string = a_string.tr('ſ','s') #old 's'
    a_string
  end   
end

class ParallelParser

  def initialize(processes_num = nil)
    require 'parallel'
    cpu_num
    if processes_num.to_i > 0
      @processes_num = [processes_num, cpu_num - 1].min
    else
      @processes_num = cpu_num > 3 ? cpu_num - 2 : 1
    end
  end

  def parse(names_list)
    parsed = Parallel.map(names_list.uniq, in_processes: @processes_num) do |n| 
      [n, parse_process(n)]
    end
    parsed.inject({}) { |res, x| res[x[0]] = x[1]; res }
  end

  def cpu_num
    @cpu_num ||= Parallel.processor_count
  end

  private
  def parse_process(name)
    p = ScientificNameParser.new
    p.parse(name) rescue ScientificNameParser::FAILED_RESULT.(name)
  end
end

# we can use these expressions when we are ready to parse virus names
# class VirusParser
#   def initialize
#     @order     = /^\s*[A-Z][a-z]\+virales/i
#     @family    = /^\s*[A-Z][a-z]\+viridae|viroidae/i
#     @subfamily = /^\s*[A-Z][a-z]\+virinae|viroinae/i
#     @genus     = /^\s*[A-Z][a-z]\+virus|viroid/i
#     @species   = /^\s*[A-z0-9u0391-u03C9\[\] ]\+virus|phage|viroid|satellite|prion[A-z0-9u0391-u03C9\[\] ]\+/i
#     @parsed    = nil
#   end
# end

class ScientificNameParser
  VERSION = open(File.join(File.dirname(__FILE__), 
                           '..',
                           '..',
                           'VERSION')).readline.strip

  FAILED_RESULT = ->(name) do
    { scientificName: 
      { parsed: false, verbatim: name.to_s.strip,  error: 'Parser error' } 
    }
  end
  
  def self.fix_case(name_string)
    name_ary = name_string.split(/\s+/)
    words_num = name_ary.size
    res = nil
    if words_num == 1
      res = name_ary[0].gsub(/[\(\)\{\}]/, '')
      if res.size > 1
        res = UnicodeUtils.upcase(res[0]) + UnicodeUtils.downcase(res[1..-1])
      else
        res = nil
      end
    else
      if name_ary[0].size > 1
        word1 = UnicodeUtils.upcase(name_ary[0][0]) + 
          UnicodeUtils.downcase(name_ary[0][1..-1])
      else
        word1 = name_ary[0]
      end
      if name_ary[1].match(/^\(/)
        word2 = name_ary[1].gsub(/\)$/, '') + ')'
        word2 = word2[0] + UnicodeUtils.upcase(word2[1]) + 
          UnicodeUtils.downcase(word2[2..-1])
      else
        word2 = UnicodeUtils.downcase(name_ary[1])
      end
      res = word1 + ' ' + 
        word2 + ' ' + 
        name_ary[2..-1].map { |w| UnicodeUtils.downcase(w) }.join(' ')
      res.strip!
    end
    res
  end

  
  def initialize(opts = {})
    @canonical_with_rank = !!opts[:canonical_with_rank]
    @verbatim = ''
    @clean = ScientificNameCleanParser.new
    @dirty = ScientificNameDirtyParser.new
    @canonical = ScientificNameCanonicalParser.new
    @parsed = nil
  end

  def virus?(a_string)
    !!(a_string.match(/\sICTV\s*$/) || 
       a_string.match(/\b(virus|viruses|phage|phages|viroid|viroids|satellite|satellites|prion|prions)\b/i) || 
       a_string.match(/[A-Z]?[a-z]+virus\b/))
  end

  def unknown_placement?(a_string)
    !!(a_string.match(/incertae\s+sedis/i) || a_string.match(/inc\.\s*sed\./i))
  end

  def parsed
    @parsed
  end
  
  def parse(a_string)
    @verbatim = a_string.strip
    a_string = PreProcessor::clean(a_string)
    
    if virus?(a_string)
      @parsed = { verbatim: a_string, virus: true }
    elsif unknown_placement?(a_string)
      @parsed = { verbatim: a_string }
    else
      begin
        @parsed = @clean.parse(a_string) || @dirty.parse(a_string) 
        unless @parsed
          index = @dirty.index || @clean.index
          salvage_match = a_string[0..index].split(/\s+/)[0..-2]
          salvage_string = salvage_match ? salvage_match.join(' ') : a_string
          @parsed =  @dirty.parse(salvage_string) || 
                     @canonical.parse(a_string) || 
                     { verbatim: a_string }
        end
      rescue
        @parsed = FAILED_RESULT.(@verbatim)
      end
    end

    def @parsed.verbatim=(a_string)
      @verbatim = a_string
    end

    def @parsed.all(opts = {})
      canonical_with_rank = !!opts[:canonical_with_rank]
      parsed = self.class != Hash
      res = { parsed: parsed, parser_version: ScientificNameParser::VERSION}
      if parsed
        hybrid = self.hybrid rescue false
        res.merge!({
          verbatim: @verbatim,
          normalized: self.value,
          canonical: self.canonical,
          hybrid: hybrid,
          details: self.details,
          parser_run: self.parser_run,
          positions: self.pos
          })
      else
        res.merge!(self)
      end
      if (canonical_with_rank && 
          canonical.count(' ') > 1 && 
          res[:details][0][:infraspecies])
        ScientificNameParser.add_rank_to_canonical(res)
      end
      res = {:scientificName => res}
    end
    
    def @parsed.pos_json
      self.pos.to_json rescue ''
    end
    
    def @parsed.all_json
      self.all.to_json rescue ''
    end

    @parsed.verbatim = @verbatim
    @parsed.all(canonical_with_rank: @canonical_with_rank)
  end
  
  private

  def self.add_rank_to_canonical(parsed)
    parts = parsed[:canonical].split(' ')
    name_ary = parts[0..1]
    parsed[:details][0][:infraspecies].each do |data|
      infrasp = data[:string]
      rank = data[:rank]
      name_ary << (rank && rank != 'n/a' ? "#{rank} #{infrasp}" : infrasp)
    end
    parsed[:canonical] = name_ary.join(' ')
  end
  
end

