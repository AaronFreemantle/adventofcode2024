# frozen_string_literal: true

garden = []

File.readlines('day12/input.txt', chomp: true).each do |line|
  garden << line.split('').map { |c| { plant: c, visited: false } }
end

regions = {}

def extend(garden, x, y, plant)
  plot = []
  if x < garden.length - 1 && !garden[y][x + 1][:visited] && garden[y][x + 1][:plant] == plant
    garden[y][x + 1][:visited] = true
    plot << [x + 1, y]
    new = extend(garden, x + 1, y, plant)
    plot += new unless new.empty?
  end
  if y < garden.length - 1 && !garden[y + 1][x][:visited] && garden[y + 1][x][:plant] == plant
    garden[y + 1][x][:visited] = true
    plot << [x, y + 1]
    new = extend(garden, x, y + 1, plant)
    plot += new unless new.empty?
  end
  if x.positive? && !garden[y][x - 1][:visited] && garden[y][x - 1][:plant] == plant
    garden[y][x - 1][:visited] = true
    plot << [x - 1, y]
    new = extend(garden, x - 1, y, plant)
    plot += new unless new.empty?
  end
  if y.positive? && !garden[y - 1][x][:visited] && garden[y - 1][x][:plant] == plant
    garden[y - 1][x][:visited] = true
    plot << [x, y - 1]
    new = extend(garden, x, y - 1, plant)
    plot += new unless new.empty?
  end
  plot.compact
end

index = 0

garden.each_with_index do |row, y|
  row.each_with_index do |tile, x|
    next if tile[:visited]

    garden[y][x][:visited] = true
    regions[index] = [[x, y]]
    regions[index] += extend(garden, x, y, tile[:plant])
    index += 1
  end
end

puts regions.keys

sum = 0

regions.values.each do |region|
  perimeter = 0
  region.each do |plot|
    unless region.include?([plot[0] - 1, plot[1]])
      perimeter += 1
    end
    unless region.include?([plot[0] + 1, plot[1]])
      perimeter += 1
    end
    unless region.include?([plot[0], plot[1] - 1])
      perimeter += 1
    end
    unless region.include?([plot[0], plot[1] + 1])
      perimeter += 1
    end
  end
  size = region.size
  puts "size: #{size}, perimeter: #{perimeter}, cost: #{size * perimeter}"
  sum += perimeter * size
end

puts sum




