#!/usr/bin/ruby
#
# I recommend using Pocket to do the export. It works better than the browser extensions.

require 'rubygems'
require 'htmlentities'
require 'csv'

# CHANGE THIS
input_file = '/home/josh/Downloads/pass.csv'
output_file = File.join(`pwd`.chomp, 'pass.xml')

coder = HTMLEntities.new
csv = CSV::parse(File.open(input_file) {|f| f.read} )
passwords = {}
csv.each do |record|
  passwords[coder.encode(record[5])] ||= []
  passwords[coder.encode(record[5])] << { :username => coder.encode(record[1]),
                                          :password => coder.encode(record[2]),
                                          :title    => coder.encode(record[4]),
                                          :comment  => coder.encode(record[3]),
                                          :url      => coder.encode(record[0]) }
end


File.open(output_file, 'w') do |f|
  f.puts '<!DOCTYPE KEEPASSX_DATABASE>'
  f.puts '<database>'
  passwords.keys.each do |key|
    f.puts '  <group>'
    f.puts "    <title>#{key}</title>"
    passwords[key].each do |password|
      f.puts "      <entry>"
      f.puts "        <title>#{password[:title]}</title>"
      f.puts "        <username>#{password[:username]}</username>"
      f.puts "        <password>#{password[:password]}</password>"
      f.puts "        <url>#{password[:url]}</url>"
      f.puts "        <comment>#{password[:comment]}</comment>"
      f.puts "      </entry>"
    end
    f.puts '  </group>'
  end
  f.puts '</database>'
end
