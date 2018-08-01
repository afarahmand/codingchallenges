# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  if nums.length < 4
    return 0 if nums.length == 0
    return nums[0] if nums.length == 1
    return nums.max if nums.length == 2
    return [nums[0] + nums[2], nums[1]].max if nums.length == 3
  end

  # Choose the 0th house, then recursively call this function to choose best combination of remaining houses
  first_element = nums[0] + rob(nums[2..-1])

  # Choose the 1st house, then use recursion to make best decision on remaining houses
  second_element = nums[1] + rob(nums[3..-1])

  return [first_element, second_element].max
end
