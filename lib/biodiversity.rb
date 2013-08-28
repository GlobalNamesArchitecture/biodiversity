require 'rubygems'
require 'treetop'

module Biodiversity
  VERSION = '3.1.2'
  LSID_RESOLVER_URL = 'http://lsid.tdwg.org/'
end

require_relative 'biodiversity/parser'
require_relative 'biodiversity/guid'

