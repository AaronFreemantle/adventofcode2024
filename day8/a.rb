# frozen_string_literal: true

grid = []

File.readlines('day8/input.txt', chomp: true).each do |line|
  grid << line.split('')
end

antennas = {}

grid.each_with_index do |row, y|
  row.each_with_index do |freq, x|
    next unless freq != '.'

    antennas[freq] ||= []
    antennas[freq] << [x, y]
  end
end

antinodes = []

antennas.each_value do |positions|
  positions.each do |current|
    positions.each do |other|
      difference = [other[0] - current[0], other[1] - current[1]]
      next if difference == [0, 0]

      antinode = [other[0] + difference[0], other[1] + difference[1]]
      next unless antinode[0] >= 0 && antinode[0] < grid[0].size && antinode[1] >= 0 && antinode[1] < grid.size

      antinodes << antinode unless antinodes.include?(antinode)
    end
  end
end

puts antinodes.size
