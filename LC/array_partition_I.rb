# @param {Integer[]} nums
# @return {Integer}
def array_pair_sum(nums)
  nums.sort!
  sum = 0
  nums.each_slice(2) do |slice|
    sum+=[slice[0], slice[1]].min
  end

  sum
end
