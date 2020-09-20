# frozen_string_literal: true

require_relative 'parser/gnparser'

module Biodiversity
  # Parser provides a namespace for functions to parse scientific names.
  module Parser
    @compact_gnparser = GnParser::Compact.new
    @csv_gnparser = GnParser::Csv.new

    def self.parse(name, simple = false)
      (simple ? @csv_gnparser : @compact_gnparser).parse(name)
    end

    def self.parse_ary(ary, simple = false)
      (simple ? @csv_gnparser : @compact_gnparser).parse_ary(ary)
    end
  end
end
