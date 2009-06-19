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
    @parser = nil
  end
  
  def parse(a_string)
    @verbatim = a_string
    @parser = @clean.parse(a_string) || @dirty.parse(a_string) || @canonical.parse(a_string) || {:verbatim => a_string}
    def @parser.to_json
      parsed = self.class != Hash
      res = {:parsed => parsed}
      if parsed
        res.merge!({
          :verbatim => self.text_value,
          :normalized => self.value,
          :canonical => self.canonical
          })
        data = self.details
        if data[:species] && data[:species][:namedHybrid]
          data[:species].delete(:namedHybrid)
          data = {:namedHybrid => data}
        end
        res.merge!(data)
      else
        res.merge!(self)
      end
      res = {:scientificName => res}
      JSON.generate res
    end
    
    def @parser.pos_json
      JSON.generate self.pos rescue ''
    end
    @parser
  end
end

