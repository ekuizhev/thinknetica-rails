print "Enter side A of a triangle: "
a = gets.chomp.to_f

print "Enter side B of a triangle: "
b = gets.chomp.to_f

print "Enter side C of a triangle: "
c = gets.chomp.to_f

cathetus1, cathetus2, hypotenuse = [a, b, c].sort

right_triangle = cathetus1**2 + cathetus2**2 == hypotenuse**2
right_isosceles_triangle = right_triangle && cathetus1 == cathetus2
equilateral_triangle = cathetus1 == hypotenuse

if equilateral_triangle
  puts "Triangle is isosceles and equilateral!"
elsif right_triangle
  puts "Triangle is rectangular#{" and isosceles" if right_isosceles_triangle}!"
else
  puts "Triangle isn't rectangular!"
end
