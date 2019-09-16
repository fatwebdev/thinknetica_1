fibonacci_seq = [0, 1]

while (fibonacci_number = fibonacci_seq[-2] + fibonacci_seq[-1]) < 100
  fibonacci_seq << fibonacci_number
end

puts fibonacci_seq
