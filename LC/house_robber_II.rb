# @param {Integer[]} nums
# @return {Integer}
def rob1(arr)
  return 0 if arr.length == 0
  return arr[0] if arr.length == 1
  return [arr[0], arr[1]].max if arr.length == 2

  dp = {}
  dp[0] = arr[0]
  dp[1] = [dp[0], arr[1]].max

  i = 2
  while i < arr.length
    dp[i] = [dp[i-2] + arr[i], dp[i-1]].max
    i+=1
  end

  dp[i-1]
end

def rob(arr)
  return 0 if arr.empty?
  return arr[0] if arr.length == 1
  [rob1(arr[0..-2]), rob1(arr[1..-1])].max
end
