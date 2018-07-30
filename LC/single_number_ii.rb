# @param {Integer[]} nums
# @return {Integer}

def convert_num_to_string_of_bits(num)
  num.to_s(2).split('')
end

def bitwise_sum(bitwise_sum, num)
  arrayed_binary_num = convert_num_to_string_of_bits(num)

  while bitwise_sum.length < arrayed_binary_num.length
    bitwise_sum << 0
  end

  # reverse moves LSB to be first bit while "eaching"
  arrayed_binary_num.reverse.each_with_index do |bit, idx|
    bitwise_sum[idx]+=1 if bit == "1"
  end

  bitwise_sum
end

def single_number(nums)
  bitwise_sum = []
  arrayed_single_number = []
  single_number = 0

  nums.each do |num|
    bitwise_sum = bitwise_sum(bitwise_sum, num)
  end

  # Find unique number from bitwise sum
  bitwise_sum.each do |bit_sum|
    arrayed_single_number << bit_sum % 3
  end

  arrayed_single_number.each_with_index do |bit, idx|
    single_number+=(2**idx)*bit
  end

  return single_number if nums.include?(single_number)

  single_number*-1
end

# a = [2,2,6,2]
# b = [1,2]

# p single_number(a)
