#! /usr/bin/env ruby

require 'csv'
require 'json'

csv_filepath = ARGV[0]
raise "Please provide a filepath to the csv to import." unless csv_filepath

rows = CSV.read(csv_filepath)
headers = rows[0]
rows = rows[1..-1]

result = rows.collect do |row|
  hash = {}

  headers.each_with_index do |header, index|
    hash[header] = row[index]
  end

  hash
end

puts result.to_json