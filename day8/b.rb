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

      antinodes << current unless antinodes.include?(current)
      antinode = other.dup
      while antinode[0] >= 0 && antinode[0] < grid[0].size && antinode[1] >= 0 && antinode[1] < grid.size
        antinode = [antinode[0] + difference[0], antinode[1] + difference[1]]
        antinodes << antinode unless antinodes.include?(antinode) || !(antinode[0] >= 0 && antinode[0] < grid[0].size && antinode[1] >= 0 && antinode[1] < grid.size)
      end
    end
  end
end

puts antinodes.size
puts antinodes.to_s
