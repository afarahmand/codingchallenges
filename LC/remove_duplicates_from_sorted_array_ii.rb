# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
  return nums.length if nums.length < 3

  i = 0
  while i < nums.length
    num = nums[i]
    until nums.count(num) < 3
      nums.delete_at(i)
    end

    i+=1
  end

  nums.length
end
