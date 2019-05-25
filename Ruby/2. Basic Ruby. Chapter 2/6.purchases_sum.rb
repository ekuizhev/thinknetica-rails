products = {}

loop do
  puts "Enter product name or stop for exit:"
  name = gets.chomp
  break if name.downcase == "stop"

  puts "Enter unit price:"
  price = gets.to_f

  puts "Enter amount purchased:"
  total = gets.to_i

  products[name] = {
    unit_price: price,
    amount_purchased: total,
    result_sum: price * total
  }
end

total_sum = 0
puts "\n---------RESULT---------"

products.each do |name, product|
  puts "Product: #{name}"
  puts "Unit price: #{product[:unit_price]}"
  puts "Purchased of amount: #{product[:amount_purchased]}"
  puts "Result sum: #{product[:result_sum]}\n\n"
  total_sum += product[:result_sum]
end

puts "\nTotal sum: #{total_sum}"
