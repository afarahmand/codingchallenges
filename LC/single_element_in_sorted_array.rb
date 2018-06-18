# @param {Integer[]} nums
# @return {Integer}

def single_non_duplicate(nums)
  return nums[0] if nums.length == 1
  mid_idx = nums.length/2

  left = nums[0..mid_idx-1]
  right = nums[mid_idx+1..-1]

  if left.last == nums[mid_idx]
    left.pop

    if left.length.odd?
      return single_non_duplicate(left)
    else
      return single_non_duplicate(right)
    end
  elsif nums[mid_idx] == right.first
    right.shift

    if right.length.odd?
      return single_non_duplicate(right)
    else
      return single_non_duplicate(left)
    end
  else
    return nums[mid_idx]
  end
end
