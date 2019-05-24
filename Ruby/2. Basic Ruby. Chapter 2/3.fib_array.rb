def get_fib_array(max_num, curr_num=0, arr=[])
  if curr_num == 0
    return [0] if max_num == 0
    return -1 if max_num < 0
    return get_fib_array(max_num, 1, [0, 1])
  end

  if curr_num > max_num
    return arr
  else
    next_val =  curr_num + arr[-1]
    arr << curr_num
    return get_fib_array(max_num, next_val, arr)
  end
end

max_num = 100
fib_arr = get_fib_array(max_num)

puts "#{fib_arr}"
