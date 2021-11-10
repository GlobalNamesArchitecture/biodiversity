# frozen_string_literal: true

# Biodiversity module provides a namespace for scientific name parser.
module Biodiversity
  VERSION = '5.5.2'
  GNPARSER_VERSION = 'GNparser 1.5.2'

  def self.version
    VERSION
  end

  def self.gnparser_version
    GNPARSER_VERSION
  end
end
