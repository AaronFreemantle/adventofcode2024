# frozen_string_literal: true

grid = []
guard = {x: nil, y: nil, dir: '^'}

def rotate(dir)
  case dir
  when '^'
    '>'
  when '>'
    'v'
  when 'v'
    '<'
  when '<'
    '^'
  else
    '^'
  end
end

def move(grid, guard)
  xdiff = 0
  ydiff = 0

  case guard[:dir]
  when '^'
    ydiff = -1
  when '>'
    xdiff = 1
  when 'v'
    ydiff = 1
  when '<'
    xdiff = -1
  end

  grid[guard[:y]][guard[:x]] = 'X'

  if (guard[:x] + xdiff).negative? ||
    guard[:x] + xdiff >= grid[0].size ||
    (guard[:y] + ydiff).negative? ||
    guard[:y] + ydiff >= grid.size
    return false
  end

  if grid[guard[:y] + ydiff][guard[:x] + xdiff] == '#'
    guard[:dir] = rotate(guard[:dir])
    return true
  end

  guard[:x] += xdiff
  guard[:y] += ydiff

  grid[guard[:y]][guard[:x]] = guard[:dir]

  true
end

File.readlines('day6/input.txt', chomp: true).each_with_index do |line, i|
  grid[i] = line.split('')
  grid[i].each_with_index do |char, j|
    if char == '^'
      guard[:x] = j
      guard[:y] = i
    end
  end
end

while move(grid, guard)
end

sum = 0
grid.each do |row|
  puts row.join
  sum += row.count('X')
end
puts sum


