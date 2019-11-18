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
               when 'mswin64'
                 'win'
               else
                 raise "Unsupported platform: #{Gem.platforms[1].os}"
               end
    ffi_lib File.join(__dir__, '..', '..', 'clib', platform, 'libgnparser.so')
    POINTER_SIZE = FFI.type_size(:pointer)

    attach_function(:parse_go, :ParseToString, %i[string string], :string)
    attach_function(:parse_ary_go, :ParseAryToStrings,
                    %i[pointer int string pointer], :void)

    def self.parse(name, simple = false)
      format = simple ? 'simple' : 'compact'
      parsed = parse_go(name, format)
      output(parsed, simple)
    end

    def self.parse_ary(ary, simple = false)
      format = simple ? 'simple' : 'compact'
      in_ptr = FFI::MemoryPointer.new(:pointer, ary.length)
      in_ptr.write_array_of_pointer(
        ary.map { |s| FFI::MemoryPointer.from_string(s) }
      )
      out_var = FFI::MemoryPointer.new(:pointer)
      parse_ary_go(in_ptr, ary.length, format, out_var)

      out_var.read_pointer
             .get_array_of_string(0, ary.length)
             .each_with_object([]) do |prsd, a|
        a << output(prsd, simple)
      end
    ensure
      out_var.read_pointer.get_array_of_pointer(0, ary.length).each do |p|
        CLib.free(p)
      end
      CLib.free(out_var.read_pointer)
    end

    def self.output(parsed, simple)
      if simple
        parsed = parsed.split('|')
        {
          id: parsed[0],
          verbatim: parsed[1],
          canonicalName: {
            full: parsed[2],
            simple: parsed[3],
            stem: parsed[4]
          },
          authorship: parsed[5],
          quality: parsed[6]
        }
      else
        JSON.parse(parsed, symbolize_names: true)
      end
    end
  end
end
