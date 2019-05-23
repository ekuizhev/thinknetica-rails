require 'date'

days_of_months = {}
curr_year = Date.today.year

(1..12).each do |month|
  date = Date.new(curr_year, month, -1)
  month = date.strftime("%B").downcase
  days = date.day
  days_of_months[month] = days
end

puts "Current year is #{curr_year}!"
puts "For these months, the number of days is 30!\n"

days_of_months.each do |month, days|
  if days == 30
    puts month
  end
end
