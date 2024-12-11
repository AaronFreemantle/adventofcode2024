# frozen_string_literal: true

stones = []

File.readlines('day11/input.txt', chomp: true).each do |line|
  stones = line.split(' ').map(&:to_i)
end

def blink(stones)
  i = 0
  while i < stones.size
    if stones[i].zero?
      stones[i] = 1
    elsif (stones[i].to_s.length % 2).zero?
      str = stones[i].to_s
      first, second = str.partition(/.{#{str.size / 2}}/)[1, 2]
      stones[i] = second.to_i
      stones.insert(i, first.to_i)
      i += 1
    else
      stones[i] = stones[i] * 2024
    end
    i += 1
  end
  stones
end

i = 1
25.times do
  stones = blink(stones)
  puts i
  i += 1
end

puts stones.size

