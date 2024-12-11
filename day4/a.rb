# frozen_string_literal: true

def check(grid, row, col)
  count = 0
  # Check right
  if col + 3 < grid[row].length
    if grid[row][col + 1] == 'M' && grid[row][col + 2] == 'A' && grid[row][col + 3] == 'S'
      count += 1
    end
  end
  # Check left
  if col - 3 >= 0
    if grid[row][col - 1] == 'M' && grid[row][col - 2] == 'A' && grid[row][col - 3] == 'S'
      count += 1
    end
  end
  # Check up
  if row - 3 >= 0
    if grid[row - 1][col] == 'M' && grid[row - 2][col] == 'A' && grid[row - 3][col] == 'S'
      count += 1
    end
  end
  # Check down
  if row + 3 < grid.length
    if grid[row + 1][col] == 'M' && grid[row + 2][col] == 'A' && grid[row + 3][col] == 'S'
      count += 1
    end
  end
  # Check top right
  if row - 3 >= 0 && col + 3 < grid[row].length
    if grid[row - 1][col + 1] == 'M' && grid[row - 2][col + 2] == 'A' && grid[row - 3][col + 3] == 'S'
      count += 1
    end
  end
  # Check top left
  if row - 3 >= 0 && col - 3 >= 0
    if grid[row - 1][col - 1] == 'M' && grid[row - 2][col - 2] == 'A' && grid[row - 3][col - 3] == 'S'
      count += 1
    end
  end
  # Check bottom right
  if row + 3 < grid.length && col + 3 < grid[row].length
    if grid[row + 1][col + 1] == 'M' && grid[row + 2][col + 2] == 'A' && grid[row + 3][col + 3] == 'S'
      count += 1
    end
  end
  # Check bottom left
  if row + 3 < grid.length && col - 3 >= 0
    if grid[row + 1][col - 1] == 'M' && grid[row + 2][col - 2] == 'A' && grid[row + 3][col - 3] == 'S'
      count += 1
    end
  end
  count
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
  row.each_with_index do |col, x|
    if grid[y][x] == 'X'
      sum += check(grid, y, x)
    end
  end
end

puts sum