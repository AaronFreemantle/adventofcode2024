# frozen_string_literal: true

safe = 0

def safe?(values)
  is_safe = true
  values.each_cons(2) do |a, b|
    is_safe = false if a == b || a > b || a + 3 < b
  end
  return true if is_safe

  is_safe = true
  values.reverse.each_cons(2) do |a, b|
    is_safe = false if a == b || a > b || a + 3 < b
  end
  is_safe
end

File.readlines('day2/input.txt', chomp: true).each do |line|
  values = line.split(' ').map(&:to_i)
  if safe?(values)
    safe += 1
  else
    is_safe = false
    values.each_with_index do |_, index|
      blah = values.dup
      blah.delete_at(index)
      if safe?(blah)
        is_safe = true
        break
      end
    end
    safe += 1 if is_safe
    puts values.to_s unless is_safe
  end
end

puts safe
