# frozen_string_literal: true

safe = 0
difference = 3

File.readlines('day2/input.txt', chomp: true).each do |line|
  values = line.split(' ').map(&:to_i)
  is_safe = true
  values = values.reverse if values[0] > values[1]
  values.each_cons(2) do |a, b|
    if a == b || a > b || a + difference < b
      is_safe = false
      break
    end
  end
  safe += 1 if is_safe
end

puts safe
