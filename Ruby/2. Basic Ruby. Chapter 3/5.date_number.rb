puts "Enter: day month year"
day, month, year = gets.split(" ").map(&:to_i)

mdays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

is_leap = ((year % 4).zero? && year % 100 != 0) || (year % 400).zero?

mdays[1] = 29 if is_leap

date_number = mdays[0...month - 1].sum
date_number += day

puts date_number
