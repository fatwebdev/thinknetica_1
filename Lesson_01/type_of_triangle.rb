print 'Enter length the first side of the triangle... '
a = gets.chomp.to_f

print 'Enter length the second side of the triangle... '
b = gets.chomp.to_f

print 'Enter length the third side of the triangle... '
c = gets.chomp.to_f

is_equilateral_triangle = [a, b, c].uniq.length == 1

is_isosceles_triangle = [a, b, c].uniq.length == 2 || is_equilateral_triangle

is_right_triangle = lambda do
  leg1, leg2, hypotenuse = [a, b, c].sort

  hypotenuse**2 == leg1**2 + leg2**2
end.call

puts 'This is equilateral triangle.' if is_equilateral_triangle
puts 'This is isosceles triangle.' if is_isosceles_triangle
puts 'This is right triangle.' if is_right_triangle
