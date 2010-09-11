dir = File.dirname("__FILE__")
require 'rubygems'
require 'spec'
require 'yaml'
require 'treetop'
require 'json'
require File.expand_path(dir + '../../lib/biodiversity/parser')

Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_clean'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_dirty'))
Treetop.load(File.expand_path(dir + '../../lib/biodiversity/parser/scientific_name_canonical'))

PARSER_TEST_VERSION = "test_version"

def set_parser(parser)
  @parser = parser
end

def parse(input)
  @parser.parse(input)
end

def value(input)
  parse(input).value
end

def canonical(input)
  parse(input).canonical
end

def details(input)
  parse(input).details
end

def pos(input)
  parse(input).pos
end

def json(input)
  parse(input).to_json.gsub(/"parser_version":"[^"]*"/, %Q["parser_version":"#{PARSER_TEST_VERSION}"])
end

def debug(input)
  res = parse(input)
  puts "<pre>"
    if res
      puts 'success!'
      puts res.inspect
    else
      puts input
      val = @parser.failure_reason.to_s.match(/column [0-9]*/).to_s.gsub(/column /,'').to_i
      print ("-" * (val - 1))
      print "^   Computer says 'no'!\n"
      puts @parser.failure_reason
      puts @parser.to_yaml
    end
  puts "</pre>"
end

def read_test_file
  f = open(File.expand_path(File.dirname("__FILE__") + "../../spec/parser/test_data.txt"))
  f.each do |line|
    name, jsn = line.split("|")
    if line.match(/^\s*#/) == nil && name && jsn
      yield({:name => name, :jsn => jsn})
    else
      yield({:comment => line})
    end
  end
end

