vowels = %w[a e i o u]
volwels_obj = {}

("a".."z").each.with_index(1) do |letter, index|
  volwels_obj[letter] = index if vowels.include?(letter)
end

puts volwels_obj
