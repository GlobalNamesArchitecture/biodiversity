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
    @node = nil
  end
  
  def parse(a_string)
    @verbatim = a_string
    @node = @clean.parse(a_string) || @dirty.parse(a_string) || @canonical.parse(a_string) rescue nil
    self
  end
  
  def value
    @node.value if @node
  end

  def pos
    @node.pos if @node
  end
  
  def details
    @node.details if @node
  end
  
  def canonical
    @node.canonical if @node
  end

  def to_json 
    parsed = !!@node
    if parsed
      res = {
        :parsed => parsed,
        :verbatim => @node.text_value }
      if parsed
        res.merge!({
          :normalized => @node.value,
          :canonical => @node.canonical
          })
        res.merge!(@node.details)
      end
      res = {:scientificName => res}
      JSON.generate res
    else
      JSON.generate({:parsed => parsed, :verbatim => @verbatim})
    end
  end

  def pos_to_json
    JSON.generate @node.pos rescue ''
  end

end

