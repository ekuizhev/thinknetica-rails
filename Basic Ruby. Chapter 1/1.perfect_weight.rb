print "Enter your name: "
person_name = gets.chomp.capitalize

print "Enter your height: "
person_height = gets.to_i

perfect_weight = person_height - 110

if perfect_weight > 0
  puts "#{person_name}, your perfect weight is #{perfect_weight}!"
else
  puts "Your weight is already optimal!"
end
