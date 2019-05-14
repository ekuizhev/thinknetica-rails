print "Enter side A of a triangle: "
a = Float gets.chomp

print "Enter side B of a triangle: "
b = Float gets.chomp

print "Enter side C of a triangle: "
c = Float gets.chomp

sides = [a, b, c]

uniq_sides = 4 - sides.uniq.length
is_equilateral = uniq_sides == 3
is_isosceles = uniq_sides == 2
is_rectangular = false

h = sides.max # hypotenuse
cathetus = sides - [h]
# hypotenuse in a rectangular must be greater than cathetus
if !is_equilateral && cathetus.length > 1
  first_c, second_c = cathetus
  h_result = (h ** 2).round(12)
  c_result = (first_c ** 2).round(12) + (second_c ** 2).round(12)
  is_rectangular = h_result == c_result
end

if is_equilateral
  puts "Triangle is isosceles and equilateral!"
elsif is_rectangular
  puts "Triangle is rectangular#{" and isosceles" if is_isosceles}!"
else
  puts "Triangle isn't rectangular!"
end

# test data for is rectangular and isosceles
# 1, 1, 1.4142135623730951 (Math.sqrt(2))
