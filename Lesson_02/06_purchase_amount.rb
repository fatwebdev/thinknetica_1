basket = {}

loop do
  print 'Enter product title or "stop"... '
  title = gets.chomp

  break if title == 'stop'

  print 'Enter product price... '
  price = gets.chomp.to_f

  print 'Enter product amount... '
  amount = gets.chomp.to_f

  basket[title.to_sym] = { price: price, amount: amount }

  puts "You spend to this product #{price * amount}"
end

total_sum = basket.reduce(0) do |sum, (_, product)|
  sum + product[:price] * product[:amount]
end

puts total_sum
