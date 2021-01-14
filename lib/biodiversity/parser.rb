# frozen_string_literal: true

# CLib is required to free memory after it is used by C
module CLib
  extend FFI::Library
  ffi_lib FFI::Library::LIBC
  attach_function :free, [:pointer], :void
end

module Biodiversity
  # Parser provides a namespace for functions to parse scientific names.
  module Parser
    extend FFI::Library

    platform = case Gem.platforms[1].os
               when 'linux'
                 'linux'
               when 'darwin'
                 'mac'
               when 'mingw32'
                 'win'
               else
                 raise "Unsupported platform: #{Gem.platforms[1].os}"
               end
    ffi_lib File.join(__dir__, '..', '..', 'clib', platform, 'libgnparser.so')
    POINTER_SIZE = FFI.type_size(:pointer)

    callback(:parser_callback, %i[string], :void)

    attach_function(:parse_go, :ParseToString,
                    %i[string string int], :strptr)
    attach_function(:parse_ary_go, :ParseAryToString,
                    %i[pointer int string int], :strptr)
    attach_function(:free_mem, :FreeMemory, %i[pointer], :void)

    def self.parse(name, simple: false)
      format = simple ? 'csv' : 'compact'

      parsed, ptr = parse_go(name, format, 0)
      free_mem(ptr)
      output(parsed, simple)
    end

    def self.parse_ary(ary, simple: false)
      format = simple ? 'csv' : 'compact'
      in_ptr = FFI::MemoryPointer.new(:pointer, ary.length)

      in_ptr.write_array_of_pointer(
        ary.map { |s| FFI::MemoryPointer.from_string(s) }
      )

      parsed, ptr = parse_ary_go(in_ptr, ary.length, format, 0)
      free_mem(ptr)
      if simple
        CSV.new(parsed).map do |row|
          csv_row(row)
        end
      else
        JSON.parse(parsed, symbolize_names: true)
      end
    end

    def self.output(parsed, simple)
      if simple
        csv = CSV.new(parsed)
        row = csv.readlines[0]
        csv_row(row)
      else
        JSON.parse(parsed, symbolize_names: true)
      end
    end

    def self.csv_row(row)
      {
        id: row[0],
        verbatim: row[1],
        cardinality: row[2],
        canonical: {
          stem: row[3],
          simple: row[4],
          full: row[5]
        },
        authorship: row[6],
        year: row[7],
        quality: row[8]
      }
    end
  end
end
