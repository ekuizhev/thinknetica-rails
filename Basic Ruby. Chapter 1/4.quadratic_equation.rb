print "Enter a: "
a = Float gets.chomp

print "Enter b: "
b = Float gets.chomp

print "Enter c: "
c = Float gets.chomp

D = b**2 - 4*a*c

if D > 0
  x1 = (-b + Math.sqrt(D)) / (2.0*a)
  x2 = (-b - Math.sqrt(D)) / (2.0*a)
  puts "D = #{D}"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
elsif D == 0
  x = -b / (2.0*a)
  puts "D = #{D}"
  puts "x = #{x}"
else
  puts "No roots!"
end
