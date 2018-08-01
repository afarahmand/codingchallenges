# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  return 0 if nums.length == 0
  return nums[0] if nums.length == 1
  return nums.max if nums.length == 2

  # Use dynamic programming
  dp = {}

  dp[0] = nums[0]
  dp[1] = [dp[0], nums[1]].max

  nums[2..-1].each_with_index do |num, idx|
    dp[idx+2] = [nums[idx+2] + dp[idx], dp[idx+1]].max
  end

  dp[nums.length-1]
end
