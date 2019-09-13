print 'Enter the factor a...'
a = gets.chomp.to_f

print 'Enter the factor b...'
b = gets.chomp.to_f

print 'Enter the factor c...'
c = gets.chomp.to_f

d = b**2 - 4 * a * c

if d < 0
  puts 'The quadratic equation with these coefficients has no solutions'
elsif d.zero?
  x = (-b) / (2 * a)
  puts "The quadratic equation has only one root: x = #{x}"
else
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "The quadratic equation has two roots: x1 = #{x1}, x2 = #{x2}"
end
