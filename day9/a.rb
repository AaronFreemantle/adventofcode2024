# frozen_string_literal: true

disk_map = []

File.readlines('day9/input.txt', chomp: true).each do |line|
  disk_map = line.split('').map(&:to_i)
end

file = true
disk = []
id = 0

disk_map.each do |digit|
  if file
    digit.times do
      disk << { id: id }
    end
    id += 1
  else
    digit.times do
      disk << { id: nil }
    end
  end
  file = !file
end


left = 0
right = disk.length - 1

while left <= right
  if disk[right][:id].nil?
    right -= 1
    next
  end
  if disk[left][:id].nil?
    disk[left] = disk[right]
    disk[right] = { id: nil }
    right -= 1
  end
  left += 1
end

puts disk.map { |file| file[:id].to_i }.each_with_index.map { |x, i| x * i }.sum
