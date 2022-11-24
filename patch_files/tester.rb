#!/usr/bin/env ruby

regex = ARGV.first.dup
%w(? ( ) ).each do |a|
  regex.gsub!(a, "\\#{a}")
end
regex = /#{regex}/m
find = File.read(ARGV.last).match(regex)
exit 1 if find.nil?
