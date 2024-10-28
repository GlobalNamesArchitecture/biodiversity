# frozen_string_literal: true

# Biodiversity module provides a namespace for scientific name parser.
module Biodiversity
  VERSION = '6.0.1'
  GNPARSER_VERSION = 'GNparser 1.10.3'

  def self.version
    VERSION
  end

  def self.gnparser_version
    GNPARSER_VERSION
  end
end
