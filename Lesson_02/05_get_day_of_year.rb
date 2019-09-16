print 'Enter year... '
year = gets.chomp.to_i
print 'Enter month... '
month = gets.chomp.to_i
print 'Enter day... '
day = gets.chomp.to_i

start_range = Time.new(year)
end_range = Time.new(year, month, day)

day_index = (end_range - start_range).round / 60 / 60 / 24 + 1

puts day_index
