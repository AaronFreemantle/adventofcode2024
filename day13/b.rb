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
  prize_x = prize[0].split('=')[1].to_i + 10000000000000
  prize_y = prize[1].split('=')[1].to_i + 10000000000000

  machines << { a: { x: a_x, y: a_y }, b: { x: b_x, y: b_y }, prize: { x: prize_x, y: prize_y } }
end

A = 3
B = 1

sum = 0

machines.each do |machine|
  # y = - a_x / b_x * x + prize_x / b_x
  # y = - a_y / b_y * x + prize_y / b_y
  # (b_y * prize_x - b_x * prize_y) /  (b_y * a_x - b_x * a_y) = x

  button_a_slope = - machine[:a][:x].to_f / machine[:b][:x]
  button_b_slope = - machine[:a][:y].to_f / machine[:b][:y]

  if button_a_slope == button_b_slope
    puts "slope: #{button_a_slope}"
  end

  a = (machine[:b][:y] * machine[:prize][:x] - machine[:b][:x] * machine[:prize][:y]) / (machine[:b][:y] * machine[:a][:x] - machine[:b][:x] * machine[:a][:y])
  remaining = machine[:prize][:x] - a * machine[:a][:x]
  b = remaining / machine[:b][:x]
  puts "a: #{a}, b: #{b}"
  x = a * machine[:a][:x] + b * machine[:b][:x]
  y = a * machine[:a][:y] + b * machine[:b][:y]
  if x == machine[:prize][:x] && y == machine[:prize][:y]
    sum += a * A + b * B
  end
end

puts sum

