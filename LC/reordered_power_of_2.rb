# @param {Integer} n
# @return {Boolean}

def digit_count(number)
  num_count = Hash.new(0)
  numstr = number.to_s

  i = 0
  while i < 10
    num_count[i] = numstr.count(i.to_s)
    i+=1
  end

  num_count
end

def reordered_power_of2(n)
  return true if n==1
  # Can be reordered (does the number have digits inclusive of 2,4,6,8 that are not first number)
  digit_index = n.to_s.rindex(/["2468"]/)

  return false if digit_index = nil && digit_index > 0

  exp = 0
  while true
    n_length = n.to_s.length
    comp_num = 2**exp
    comp_num_length = comp_num.to_s.length

    if comp_num_length == n_length
      # Use counter hash to count number of each digit for n and comp_num
      return true if digit_count(n) == digit_count(comp_num)
    elsif comp_num_length > n_length
      return false
    end

    exp+=1
  end
end
