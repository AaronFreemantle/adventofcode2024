# frozen_string_literal: true

rules = []
updates = []

File.readlines('day5/input.txt', chomp: true).each do |line|
  next if line.empty?

  if line.include?('|')
    rules << line.split('|').map(&:to_i)
  else
    updates << line.split(',').map(&:to_i)
  end
end

sum = 0

# updates.each do |pages|
#   ordered = true
#   pages.each_with_index do |page, page_index|
#     rules.each do |rule|
#       ordered = false if rule[0] == page && pages.take(page_index).include?(rule[1])
#       ordered = false if rule[1] == page && pages.take(page_index).include?(rule[0])
#     end
#   end
#   sum += pages[pages.size / 2 + 1].to_i if ordered
# end

def page_sort(left, right, rules)
  rules.each do |rule|
    if left == rule[0] && right == rule[1]
      return -1
    elsif left == rule[1] && right == rule[0]
      return 1
    end
  end
end

updates.each do |pages|
  ordered = pages.dup.sort do |left, right|
    page_sort(left, right, rules)
  end
  correct = ordered == pages
  sum += ordered[pages.size / 2].to_i unless correct
end

puts sum