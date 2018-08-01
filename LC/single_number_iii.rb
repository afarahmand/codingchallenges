# @param {Integer[]} nums
# @return {Integer[]}

def single_number(nums)
  xor_sum = 0
  nums.each{ |num| xor_sum^=num }

  # Create mask by finding first differing bit
  mask = 1

  while(mask & xor_sum == 0)
    mask*=2
  end

  first_number =  nums.select{|num| num&mask != 0}.inject(:^)
  second_number = nums.select{|num| num&mask == 0}.inject(:^)

  [first_number, second_number]
end
