vowels = ["a", "e", "i", "o", "u"]

volwels_obj = {}

("a".."z").each_with_index do |letter, index|
  if (vowels.include? letter)
    volwels_obj[letter] = index + 1
  end
end

puts volwels_obj
