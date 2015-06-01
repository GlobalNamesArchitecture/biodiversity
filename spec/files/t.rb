#!/usr/bin/env ruby
require "gn_uuid"

w = open("t", "w:utf-8")

open("test_data.txt").each do |line|
  name, json = line.split("|")
  if json && name.match("^\s*#").nil?
    id = GnUUID.uuid(name)
    json.gsub!(/icName":\{/, "icName\":{\"id\":\"#{id}\", ")
    w.write(name + "|" + json)
  else
    w.write(line)
  end
end
