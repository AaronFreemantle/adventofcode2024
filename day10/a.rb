# frozen_string_literal: true

map = []

File.readlines('day10/input.txt', chomp: true).each_with_index do |line, i|
  map << line.split('').map{ |char| char == '.' ? nil : char.to_i }
end

def step(map, x, y, height)
  return {x: x, y: y} if height == 9

  tops = []

  top = map[y - 1][x] if y.positive?
  right = map[y][x + 1] if x < map[0].length - 1
  bottom = map[y + 1][x] if y < map.length - 1
  left = map[y][x - 1] if x.positive?

  tops << step(map, x, y - 1, height + 1) if !top.nil? && top == height + 1
  tops << step(map, x + 1, y, height + 1) if !right.nil? && right == height + 1
  tops << step(map, x, y + 1, height + 1) if !bottom.nil? && bottom == height + 1
  tops << step(map, x - 1, y, height + 1) if !left.nil? && left == height + 1

  tops.uniq
end

sum = 0

map.each_with_index do |row, y|
  row.each_with_index do |height, x|
    next unless height == 0

    tops = step(map, x, y, height).flatten.uniq
    puts tops.to_s
    score = tops.count
    sum += score
    puts score
  end
end

puts sum
