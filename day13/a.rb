# frozen_string_literal: true

machines = []

File.readlines('day13/input.txt', chomp: true).each_cons(4) do |lines|
  next unless lines[3] == ''

  button_a = lines[0].split(':')[1].split(',')
  a_x = button_a[0].split('+')[1].to_i
  a_y = button_a[1].split('+')[1].to_i
  button_b = lines[1].split(':')[1].split(',')
  b_x = button_b[0].split('+')[1].to_i
  b_y = button_b[1].split('+')[1].to_i
  prize = lines[2].split(':')[1].split(',')
  prize_x = prize[0].split('=')[1].to_i
  prize_y = prize[1].split('=')[1].to_i

  machines << { a: { x: a_x, y: a_y }, b: { x: b_x, y: b_y }, prize: { x: prize_x, y: prize_y } }
end

A = 3
B = 1

sum = 0

machines.each do |machine|
  max_button_a = [machine[:prize][:x] / machine[:a][:x], machine[:prize][:y] / machine[:a][:y]].min
  max_button_b = [machine[:prize][:x] / machine[:b][:x], machine[:prize][:y] / machine[:b][:y]].min

  test = max_button_a > 100 || max_button_b > 100

  # max int
  best = 401
  found = false
  (0..100).each do |a|
    (0..100).each do |b|
      x = a * machine[:a][:x] + b * machine[:b][:x]
      y = a * machine[:a][:y] + b * machine[:b][:y]
      if x == machine[:prize][:x] && y == machine[:prize][:y]
        best = [best, a * A + b * B].min
        found = true
      end
    end
  end
  sum += best if found
end

puts sum

