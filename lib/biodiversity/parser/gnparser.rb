# frozen_string_literal: true

require 'open3'
require 'csv'

module Biodiversity
  # Parser provides a namespace for functions to parse scientific names.
  module Parser
    # gnparser abstract class interface
    class GnParser
      def parse(name)
        sync do
          push(name)
          pull
        end
      end

      def parse_ary(ary)
        sync do
          count = ary.count
          Thread.new do
            ary.each { |n| push(n) }
          end

          res = []
          count.times { res << pull }
          res
        end
      end

      private

      def initialize
        @semaphore = Mutex.new
        @pid = nil
      end

      def start_gnparser
        platform_suffix =
          case Gem.platforms[1].os
          when 'linux'
            'linux'
          when 'darwin'
            'mac'
          when 'mingw32'
            'win.exe'
          else
            raise "Unsupported platform: #{Gem.platforms[1].os}"
          end
        path = File.join(__dir__, '..', '..', '..',
                         'ext', "gnparser-#{platform_suffix}")

        @stdin, @stdout = Open3.popen2("#{path} --format #{format} --details --quiet --stream --jobs 1")

        init_gnparser

        @pid = Process.pid
      end

      def sync
        @semaphore.synchronize do
          start_gnparser unless Process.pid == @pid
          yield
        end
      end

      def push(name)
        name = clean_name(name)
        begin
          @stdin.puts(name)
        rescue Errno::EPIPE
          @pid = nil
          raise
        end
      end

      def pull
        begin
          output = @stdout.gets
        rescue Errno::EPIPE
          @pid = nil
          raise
        end
        parse_output(output)
      end

      def clean_name(name)
        name.gsub(/(\n|\r\n|\r)/, ' ')
      end

      def init_gnparser; end

      # gnparser interface to CSV-formatted output
      class Csv < self
        def parse_output(output)
          parsed = CSV.new(output).first
          {
            id: get_csv_value(parsed, 'Id'),
            verbatim: get_csv_value(parsed, 'Verbatim'),
            cardinality: get_csv_value(parsed, 'Cardinality'),
            canonical: {
              stemmed: get_csv_value(parsed, 'CanonicalStem'),
              simple: get_csv_value(parsed, 'CanonicalSimple'),
              full: get_csv_value(parsed, 'CanonicalFull')
            },
            authorship: get_csv_value(parsed, 'Authorship'),
            year: get_csv_value(parsed, 'Year'),
            quality: get_csv_value(parsed, 'Quality')
          }
        end

        def format
          'csv'
        end

        def init_gnparser
          @csv_mapping = {}
          CSV.new(@stdout.gets).read[0].each.with_index do |header, index|
            @csv_mapping[header] = index
          end
        end

        def get_csv_value(csv, field_name)
          csv[@csv_mapping[field_name]]
        end
      end

      # gnparser interface to JSON-formatted output
      class Compact < self
        def parse_output(output)
          JSON.parse(output, symbolize_names: true)
        end

        def format
          'compact'
        end
      end
    end

    private_constant :GnParser
  end
end
