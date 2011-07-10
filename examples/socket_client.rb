#!/usr/bin/env ruby
require 'socket'

host = 'localhost'
port = 4334

f = open('10000_names.txt')
w = open('output.txt', 'w')
s = TCPSocket.open(host, port)

f.each_with_index do |line, i|
  puts i if i % 1000 == 0
  line = line.strip
  s.puts(line.strip)
  res = s.gets
  if res && res.split(" ").size > 3
    res = res.strip
    w.write(line + "\n")
    w.write(res + "\n")
    w.write("\n")
  end
end

s.close

