# @param {Integer} num
# @return {Integer}

def get_optimized_num_str(num_str_arr, target_number)
  swap_index = num_str_arr.rindex(target_number)
  num_str_arr[0], num_str_arr[swap_index] = num_str_arr[swap_index], num_str_arr[0]
  num_str_arr
end

def maximum_swap(num)
  # Single digit num already maxed
  return num if num < 10

  # Number in reverse sorted order already maxed
  temp = num.to_s.chars
  reverse_sorted_num = temp.sort{ |x, y| y<=>x }
  return num if reverse_sorted_num == temp

  # Find the index of one number to swap
  i = 0
  while temp[i] == reverse_sorted_num[i]
    i+=1
  end

  (temp[0...i]+get_optimized_num_str(temp[i..-1], reverse_sorted_num[i])).join.to_i
end
