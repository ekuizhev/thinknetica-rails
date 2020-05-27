print "Enter side A of a triangle: "
a = gets.to_f

print "Enter side B of a triangle: "
b = gets.to_f

print "Enter side C of a triangle: "
c = gets.to_f

cathetus1, cathetus2, hypotenuse = [a, b, c].sort

right_triangle = cathetus1**2 + cathetus2**2 == hypotenuse**2
right_isosceles_triangle = right_triangle && cathetus1 == cathetus2
equilateral_triangle = cathetus1 == hypotenuse

if equilateral_triangle
  puts "Triangle is isosceles and equilateral!"
elsif right_isosceles_triangle
  puts "Triangle is rectangular and isosceles!"
elsif right_triangle
  puts "Triangle is rectangular!"
else
  puts "Triangle isn't rectangular!"
end
