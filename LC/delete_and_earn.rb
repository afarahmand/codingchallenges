# @param {Integer[]} nums
# @return {Integer}

def divide_into_cont_subsets(nums)
  sorted_nums = nums.sort
  cont_subsets = []
  subset = []

  last_num = sorted_nums[0]
  running_sum = last_num

  i = 1
  while i < nums.length
    if sorted_nums[i] == last_num
      running_sum+=last_num
    else
      subset << running_sum

      # Non-adjacent numbers
      if sorted_nums[i] != last_num+1
        cont_subsets << subset
        subset = []
      end

      running_sum = sorted_nums[i]
      last_num = sorted_nums[i]
    end

    i+=1
  end

  subset << running_sum
  cont_subsets << subset
  cont_subsets
end

def find_subtotal_of_cont_subset(nums)
  return nums[0] if nums.length == 1
  return [nums[0], nums[1]].max if nums.length == 2

  dp = {}
  dp[0] = nums[0]
  dp[1] = [nums[0], nums[1]].max

  i = 2
  while i < nums.length
    dp[i]=[dp[i-1], dp[i-2] + nums[i]].max
    i+=1
  end

  dp[i-1]
end

def delete_and_earn(nums)
  return 0 if nums.empty?
  continuous_subsets = divide_into_cont_subsets(nums)

  pt_total = 0
  continuous_subsets.each do |subset|
    pt_total+=find_subtotal_of_cont_subset(subset)
  end

  pt_total
end

a = [3, 4, 2]
b = [2, 2, 3, 3, 3, 4]
c = [1,1,1,1,2,2,2,3,3,4]
d = [8,3,4,7,6,6,9,2,5,8,2,4,9,5,9,1,5,7,1,4]
e = [1, 1, 2, 2, 3, 4, 4, 4, 5, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 9]
f = [3,7,10,5,2,4,8,9,9,4,9,2,6,4,6,5,4,7,6,10]
g = [6,5,10,2,8,6,6,5,2,9,9,4,6,3,3,7,7,8,9,5]
h=[37,6,8,34,67,54,13,26,41,54,58,34,96,40,52,59,95,61,39,30,76,99,93,34,63,77,37,47,74,65,85,93,20,43,29,60,63,46,17,28,73,49,1,71,99,93,46,29,1,44,93,64,84,73,2,10,22,87,14,70,32,58,20,87,57,17,55,55,15,16,38,67,98,78,61,13,92,32,75,64,78,25,85,34,51,28,100,30,10,45,65,52,13,80,35,8,84,1,60,11,54,92,22,26,54,30,97,54,62,59,92,64,21,69,88,27,73,20,42,5,52,93,46,71,75,63,77,18,27,14,45,72,80,36,30,89,49,79,18,24,39,9,30,27,69,7,100,56,30,77,89,97,20,65,38,17,19,92,84,99,21,49,62,52,19,78,47,62,79,29,64,36,7,9,69,80,20,24,78,93,54,79,54,96,72,76,5,63,33,20,32,36,69,69,11,35,71,79,66,46]


p delete_and_earn(a)
p delete_and_earn(b)
p delete_and_earn(c)
p delete_and_earn(d)
# p delete_and_earn(g)
p delete_and_earn(h)
