print "Enter a: "
a = gets.chomp.to_f

print "Enter b: "
b = gets.chomp.to_f

print "Enter c: "
c = gets.chomp.to_f

d = b**2 - 4 * a * c
d_sqrt = Math.sqrt(d)

if d > 0
  x1 = (-b + d_sqrt) / (2 * a)
  x2 = (-b - d_sqrt) / (2 * a)
  puts "D = #{D}"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
elsif d == 0
  x = -b / (2 * a)
  puts "D = #{d}"
  puts "x = #{x}"
else
  puts "No roots!"
end
