# frozen_string_literal: true

def check(grid, row, col)
  return false if row.zero? || col.zero? || row == grid.length - 1 || col == grid[0].length - 1

  top_left = grid[row - 1][col - 1]
  top_right = grid[row - 1][col + 1]
  bottom_left = grid[row + 1][col - 1]
  bottom_right = grid[row + 1][col + 1]

  letters = [top_left, top_right, bottom_left, bottom_right]
  m_count = letters.count('M')
  s_count = letters.count('S')

  return false if m_count != 2 || s_count != 2
  return false if top_left == 'M' && bottom_right == 'M' || top_right == 'M' && bottom_left == 'M'

  true
end

sum = 0
row = 0
grid = []
File.readlines('day4/input.txt', chomp: true).each do |line|
  grid[row] = []
  line.split('').each_with_index do |letter, col|
    grid[row][col] = letter
  end
  row += 1
end

grid.each_with_index do |row, y|
  row.each_with_index do |_, x|
    sum += 1 if grid[y][x] == 'A' && check(grid, y, x)
  end
end

puts sum