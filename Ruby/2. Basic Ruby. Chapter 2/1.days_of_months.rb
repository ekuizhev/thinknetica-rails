require 'date'

days_of_months = {}
current_year = Date.today.year

(1..12).each do |month|
  date = Date.new(current_year, month, -1)
  month = date.strftime("%B").downcase
  days = date.day
  days_of_months[month] = days
end

puts "Current year is #{current_year}!"
puts "For these months, the number of days is 30!\n\n"

days_of_months.each { |month, days| puts month if days == 30 }
