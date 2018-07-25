# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def move_zeroes(nums)
  swaps = 0
  zero_count = 0

  nums.each do |num|
    zero_count +=1 if num == 0
  end

  i = 0
  nonzero_idx = 0 # Each nonzero number is placed here
  while i < nums.length
    if nums[i] != 0
      if nums[i] != nums[nonzero_idx]
        swaps+=1
        nums[nonzero_idx] = nums[i]
      end

      nonzero_idx+=1
    end
    i+=1
  end

  while zero_count > 0
    nums[nums.length - zero_count] = 0
    zero_count-=1
  end
end
