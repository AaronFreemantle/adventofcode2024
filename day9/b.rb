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
    disk << { id: id, size: digit }
    id += 1
  else
    disk << { id: nil, size: digit }
  end
  file = !file
end

id -= 1

while id >= 0
  right = disk.find_index { |file| file[:id] == id }
  gap = disk.find_index { |block| block[:id].nil? && block[:size] >= disk[right][:size] }

  if gap.nil? || right <= gap
    id -= 1
    next
  end

  if disk[right][:size] == disk[gap][:size]
    disk[gap][:id] = disk[right][:id]
    disk[right][:id] = nil
  end

  if disk[right][:size] < disk[gap][:size]
    disk[gap][:size] -= disk[right][:size]
    disk.insert(gap, { id: disk[right][:id], size: disk[right][:size] })
    disk[right + 1][:id] = nil
  end

  id -= 1
end

out = ''
disk.each do |file|
  out += if file[:id].nil?
           ('.' * file[:size]).to_s
         else
           (file[:id].to_s * file[:size]).to_s
         end
end
sum = 0
index = 0

disk.each do |file|
  if file[:id].nil?
    index += file[:size]
    next
  end
  file[:size].times do
    sum += file[:id] * index
    index += 1
  end
end

puts sum
