# frozen_string_literal: true

first = []
second = []
File.readlines('input.txt', chomp: true).each do |line|
  first << line.split(' ').first
  second << line.split(' ').last
end

first = first.sort
second = second.sort

sum = 0

first.each_with_index do |f, i|
  puts "#{f} #{second[i]}"
  sum += (f.to_i - second[i].to_i).abs
end

puts sum
