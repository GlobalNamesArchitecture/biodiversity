# frozen_string_literal: true

require_relative 'parser/gnparser'

module Biodiversity
  # Parser provides a namespace for functions to parse scientific names.
  module Parser
    @compact_gnparser = {
      false => GnParser::Compact.new,
      true => GnParser::Compact.new('--cultivar')
    }
    @csv_gnparser = {
      false => GnParser::Csv.new,
      true => GnParser::Csv.new('--cultivar')
    }

    def self.parse(name, simple: false, with_cultivars: false)
      (simple ? @csv_gnparser[!!with_cultivars] : @compact_gnparser[!!with_cultivars]).parse(name)
    end

    def self.parse_ary(ary, simple: false, with_cultivars: false)
      (simple ? @csv_gnparser[!!with_cultivars] : @compact_gnparser[!!with_cultivars]).parse_ary(ary)
    end
  end
end
