require 'treetop'
require 'json'
require 'open-uri'
require_relative 'biodiversity/version'
require_relative 'biodiversity/parser'
require_relative 'biodiversity/guid'

module Biodiversity
  LSID_RESOLVER_URL = 'http://lsid.tdwg.org/' 

  def self.version
    VERSION
  end
end

