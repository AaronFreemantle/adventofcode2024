# frozen_string_literal: true

stones = []

File.readlines('day11/input.txt', chomp: true).each do |line|
  stones = line.split(' ').map { |stone| [stone.to_i, 1] }
end

75.times do
  cache = {}

  stones.each do |stone|
    value, index = stone
    if value.zero?
      cache[1] = cache[1] ? cache[1] + index : index
    elsif (value.to_s.length % 2).zero?
      str = value.to_s
      first, second = str.partition(/.{#{str.size / 2}}/)[1, 2]
      cache[first.to_i] = cache[first.to_i] ? cache[first.to_i] + index : index
      cache[second.to_i] = cache[second.to_i] ? cache[second.to_i] + index : index
    else
      multiplied = value * 2024
      cache[multiplied] = cache[multiplied] ? cache[multiplied] + index : index
    end
  end

  stones = cache
end

puts stones.values.sum

