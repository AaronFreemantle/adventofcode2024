# frozen_string_literal: true

sum = 0
input = File.read('day3/input.txt')
on = true

input.scan(/mul\(\d{1,3},\d{1,3}\)|don't|do/).each do |c|
  if c.include?("don't")
    on = false
    next
  end
  if c.include?('do')
    on = true
    next
  end
  next unless on

  puts c
  a = c.scan(/\d{1,3}/)[0].to_i
  b = c.scan(/\d{1,3}/)[1].to_i
  sum += a * b
  puts a, b
end

puts sum
