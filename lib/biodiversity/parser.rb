# encoding: UTF-8
dir = File.dirname(__FILE__)
require File.join(dir, *%w[parser scientific_name_clean])
require File.join(dir, *%w[parser scientific_name_dirty])
require File.join(dir, *%w[parser scientific_name_canonical])
require 'rubygems'
require 'json'

class ScientificNameParser
  
  def initialize
    @verbatim = ''
    @clean = ScientificNameCleanParser.new
    @dirty = ScientificNameDirtyParser.new
    @canonical = ScientificNameCanonicalParser.new
    @parsed = nil
  end
  
  def parsed
    @parsed
  end
  
  def parse(a_string)
    @verbatim = a_string
    @parsed = @clean.parse(a_string) || @dirty.parse(a_string) || @canonical.parse(a_string) || {:verbatim => a_string}
    def @parsed.all
      parsed = self.class != Hash
      res = {:parsed => parsed}
      if parsed
        hybrid = self.hybrid rescue false
        res.merge!({
          :verbatim => self.text_value,
          :normalized => self.value,
          :canonical => self.canonical,
          :hybrid => hybrid,
          :details => self.details,
          :positions => self.pos
          })
      else
        res.merge!(self)
      end
      res = {:scientificName => res}
      res
    end
    
    def @parsed.pos_json
      JSON.generate self.pos rescue ''
    end
    
    def @parsed.all_json
      JSON.generate self.all
    end
    
    @parsed.all
  end
end

