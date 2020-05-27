print "Enter a: "
a = gets.to_f

print "Enter b: "
b = gets.to_f

print "Enter c: "
c = gets.to_f

d = b**2 - 4 * a * c

if d.positive?
  sqrt = Math.sqrt(d)
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  puts "D = #{d}"
  puts "x1 = #{x1}"
  puts "x2 = #{x2}"
elsif d.zero?
  x = -b / (2.0 * a)
  puts "D = #{d}"
  puts "x = #{x}"
else
  puts "No roots!"
end
