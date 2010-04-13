# encoding: UTF-8
dir = File.dirname(__FILE__)
require File.join(dir, *%w[parser scientific_name_clean])
require File.join(dir, *%w[parser scientific_name_dirty])
require File.join(dir, *%w[parser scientific_name_canonical])
require 'rubygems'
require 'json'

module PreProcessor
  NOTES = /\s+(species\s+group|species\s+complex|group)\b.*$/i
  TAXON_CONCEPTS1 = /\s+(sensu\.|sensu|auct\.|auct)\b.*$/i
  TAXON_CONCEPTS2 = /\s+(\(?s\.\s?s\.|\(?s\.\s?l\.|\(?s\.\s?str\.|\(?s\.\s?lat\.|sec\.|sec)\b.*$/
  TAXON_CONCEPTS3 = /(,\s*|\s+)(pro parte|p.\s?p.)\s*$/i  
  NOMEN_CONCEPTS = /(,\s*|\s+)(\(?nomen|\(?nom\.|\(?comb\.).*$/i
  
  def self.clean(a_string)
    [NOTES, TAXON_CONCEPTS1, TAXON_CONCEPTS2, TAXON_CONCEPTS3, NOMEN_CONCEPTS].each do |i|
      a_string = a_string.gsub(i, '')
    end
    a_string = a_string.tr('ſ','s') #old 's'
    a_string
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
  
  def initialize
    @verbatim = ''
    @clean = ScientificNameCleanParser.new
    @dirty = ScientificNameDirtyParser.new
    @canonical = ScientificNameCanonicalParser.new
    @parsed = nil
  end

  def virus?(a_string)
    !!(a_string.match(/\sICTV\s*$/) || a_string.match(/\s(virus|phage|viroid|satellite|prion)\b/i))
  end 

  def parsed
    @parsed
  end
  
  def parse(a_string)
    @verbatim = a_string
    a_string = PreProcessor::clean(a_string)
    
    if virus?(a_string)
      @parsed = { :verbatim => a_string, :virus => true }
    else
      @parsed = @clean.parse(a_string) || @dirty.parse(a_string) || @canonical.parse(a_string) || { :verbatim => a_string }
    end

    def @parsed.verbatim=(a_string)
      @verbatim = a_string
    end

    def @parsed.all(verbatim = @verbatim)
      parsed = self.class != Hash
      res = {:parsed => parsed}
      if parsed
        hybrid = self.hybrid rescue false
        res.merge!({
          :verbatim => @verbatim,
          :normalized => self.value,
          :canonical => self.canonical,
          :hybrid => hybrid,
          :details => self.details,
          :parser_run => self.parser_run,
          :positions => self.pos
          })
      else
        res.merge!(self)
      end
      res = {:scientificName => res}
      res
    end
    
    def @parsed.pos_json
      self.pos.to_json rescue ''
    end
    
    def @parsed.all_json
      self.all.to_json rescue ''
    end

    @parsed.verbatim = @verbatim
    @parsed.all
  end
end

