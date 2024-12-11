# frozen_string_literal: true

first = []
second = []
File.readlines('input.txt', chomp: true).each do |line|
  first << line.split(' ').first
  second << line.split(' ').last
end

sum = 0

first.each do |f|
  count = 0
  second.each do |s|
    count += 1 if f.to_i == s.to_i
  end
  sum += f.to_i * count if count.positive?
end

puts sum
