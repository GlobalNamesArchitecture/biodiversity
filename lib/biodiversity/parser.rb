# encoding: UTF-8
dir = File.dirname(__FILE__)
require File.join(dir, *%w[parser scientific_name_clean])
require File.join(dir, *%w[parser scientific_name_dirty])
require File.join(dir, *%w[parser scientific_name_canonical])


class ScientificNameParser
  
  def initialize
    @clean = ScientificNameCleanParser.new
    @dirty = ScientificNameDirtyParser.new
    @canonical = ScientificNameCanonicalParser.new
  end
  
  def parse(a_string)
    @clean.parse(a_string) || @dirty.parse(a_string) || @canonical.parse(a_string)
  end

end

