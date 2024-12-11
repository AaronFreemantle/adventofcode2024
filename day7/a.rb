# frozen_string_literal: true

calibrations = []

File.readlines('day7/input.txt', chomp: true).each do |line|
  result = line.split(':')[0]
  values = line.split(':')[1].split(' ')

  calibrations << {
    result: result.to_i,
    values: values.map(&:to_i)
  }
end

sum = 0

calibrations.each do |calibration|
  tests = %i[+ * or].repeated_permutation(calibration[:values].size - 1).to_a

  tests.each do |test|
    value = calibration[:values].first
    test.each_with_index do |operator, index|
      value = if operator == :or
                (value.to_s + calibration[:values][index + 1].to_s).to_i
              else
                value.send(operator, calibration[:values][index + 1])
              end
    end
    next unless value == calibration[:result]

    sum += calibration[:result]
    break
  end

end

puts sum