require 'rubygems'
require 'treetop'

dir = File.dirname(__FILE__)

BIODIVERSITY_ROOT = File.join(dir, 'biodiversity')
require File.join(dir, "/../conf/environment")
require File.join(BIODIVERSITY_ROOT, "parser")
require File.join(BIODIVERSITY_ROOT, "guid")


