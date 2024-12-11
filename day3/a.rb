# frozen_string_literal: true

sum = 0
input = File.read('day3/input.txt')

input.scan(/mul\(\d{1,3},\d{1,3}\)/).each do |c|
  puts c
  a = c.scan(/\d{1,3}/)[0].to_i
  b = c.scan(/\d{1,3}/)[1].to_i
  sum += a * b
  puts a, b
end

puts sum