products = {}

loop do
  puts "Enter product name or stop for exit:"
  name = gets.chomp
  break if name == "stop"

  puts "Enter unit price:"
  price = gets.to_f

  puts "Enter amount purchased:"
  total = gets.to_i

  products[name] = {
    "unit_price" => price,
    "amount_purchased" => total,
    "result_sum" => price * total
  }
end

total_sum = products.map {|k, v| v["result_sum"]}.reduce(:+)

puts products
puts "Total sum: #{total_sum}"
