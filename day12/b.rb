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

sum = 0
index = 0
perimeters = {}

regions.values.each do |region|
  perimeters[index] = []
  region.each do |plot|
    perimeters[index] << { x: plot[0], y: plot[1], visited: false, side: 'left' } unless region.include?([plot[0] - 1, plot[1]])
    perimeters[index] << { x: plot[0], y: plot[1], visited: false, side: 'right' } unless region.include?([plot[0] + 1, plot[1]])
    perimeters[index] << { x: plot[0], y: plot[1], visited: false, side: 'top' } unless region.include?([plot[0], plot[1] - 1])
    perimeters[index] << { x: plot[0], y: plot[1], visited: false, side: 'bottom' } unless region.include?([plot[0], plot[1] + 1])
  end
  # puts perimeters[index].to_s
  index += 1
end

perimeters.each do |index, perimeter|
  walls = 0
  perimeter.sort { |a, b| a[:y] == b[:y] ? a[:x] <=> b[:x] : a[:y] <=> b[:y] }.each do |wall|
    next if wall[:visited]

    wall[:visited] = true
    walls += 1

    if wall[:side] == 'top'
      x = wall[:x] + 1
      while perimeter.include?({ x: x, y: wall[:y], visited: false, side: 'top' })
        perimeter.find { |w| w[:x] == x && w[:y] == wall[:y] && w[:side] == 'top' }[:visited] = true
        x += 1
      end
    end
    if wall[:side] == 'bottom'
      x = wall[:x] + 1
      while perimeter.include?({ x: x, y: wall[:y], visited: false, side: 'bottom' })
        perimeter.find { |w| w[:x] == x && w[:y] == wall[:y] && w[:side] == 'bottom' }[:visited] = true
        x += 1
      end
    end
    if wall[:side] == 'left'
      y = wall[:y] + 1
      while perimeter.include?({ x: wall[:x], y: y, visited: false, side: 'left' })
        perimeter.find { |w| w[:x] == wall[:x] && w[:y] == y && w[:side] == 'left' }[:visited] = true
        y += 1
      end
    end
    if wall[:side] == 'right'
      y = wall[:y] + 1
      while perimeter.include?({ x: wall[:x], y: y, visited: false, side: 'right' })
        perimeter.find { |w| w[:x] == wall[:x] && w[:y] == y && w[:side] == 'right' }[:visited] = true
        y += 1
      end
    end
  end
  # puts "walls: #{walls}"
  sum += walls * regions[index].size
end

puts sum




