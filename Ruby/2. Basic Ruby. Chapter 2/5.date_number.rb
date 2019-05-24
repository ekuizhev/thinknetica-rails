puts "Enter: day month year"
day, month, year = gets.split(" ").map { |el| el.to_i }

mdays = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

is_leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0

if is_leap
  mdays[2] = 29
end

date_number = 0

(1...month).each do |m|
  date_number += mdays[m]
end
date_number += day - 1

puts date_number
