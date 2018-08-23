# @param {Integer[]} nums
# @return {Integer}

def divide_into_cont_subsets(nums)
  sorted_nums = nums.sort
  cont_subsets = []
  subset = []

  return [[nums[0]]] if nums.length == 1

  # p "Testing..."
  # p sorted_nums

  sorted_nums.each do |num|
    if subset.empty? || (num <= (subset[-1] + 1))
      subset << num
    else
      cont_subsets << subset
      subset = []
      subset << num
    end
  end

  cont_subsets << subset

  # p cont_subsets

  cont_subsets
end

def find_subtotal_of_cont_subset(nums)
  # p nums.sort
  # Find the count of each integer in nums
  num_count = get_num_count(nums)

  # For each num, find the value gained by picking all of that num and removing all of num-1 and num+1
  us_nums = nums.uniq.sort        # uniq, sorted nums

  num_costs = []
  us_nums.each{ |num| num_costs << num*num_count[num] - ((num-1)*num_count[num-1] + (num+1)*num_count[num+1]) }

  pt_total = 0
  while !us_nums.empty?
    # Select num with max cost
    highest_cost = num_costs.max
    index_of_best_num = num_costs.index(highest_cost)

    # When equal cost options are available for selection, this algorithm selects the lowest index
    #   one for deletion.  However, in the special case of a length 3 array, we must select according
    #   to a different criteria
    if us_nums.length == 3 && index_of_best_num == 1
      index_of_best_num = 0 if take_outer_nums?(us_nums, num_count)
    end

    selected_num = us_nums[index_of_best_num]

    # p "---"
    # p num_costs
    # p us_nums
    # p selected_num

    pt_total+=(selected_num * num_count[selected_num])

    # Remove integers from nums and update num_cost (Set cost of self and surrounding nums to 0)
    temp = update_after_selection(selected_num, num_count, us_nums, num_costs)
    num_costs = temp.pop
    us_nums = temp.pop
    num_count = temp.pop
  end

  p "Total: " + pt_total.to_s

  pt_total
end

# Count the frequency of each integer in input array
def get_num_count(nums)
  sorted_nums = nums.sort
  num_count = Hash.new(0)

  sorted_nums.each{ |num| num_count[num]+=1 }

  num_count
end

def update_after_selection(selected_num, num_count, us_nums, num_costs)
  if us_nums.include?(selected_num - 1)
    if us_nums.include?(selected_num - 2)
      num_index = us_nums.index(selected_num - 2)
      num_costs[num_index]+=(selected_num-1)*num_count[selected_num-1]
    end

    index_to_delete = us_nums.index(selected_num-1)
    us_nums.delete_at(index_to_delete)
    num_costs.delete_at(index_to_delete)
    num_count.delete(selected_num-1)
  end

  if us_nums.include?(selected_num + 1)
    if us_nums.include?(selected_num + 2)
      num_index = us_nums.index(selected_num + 2)
      num_costs[num_index]+=(selected_num+1)*num_count[selected_num+1]
    end

    index_to_delete = us_nums.index(selected_num+1)
    us_nums.delete_at(index_to_delete)
    num_costs.delete_at(index_to_delete)
    num_count.delete(selected_num+1)
  end

  index_to_delete = us_nums.index(selected_num)
  us_nums.delete_at(index_to_delete)
  num_costs.delete_at(index_to_delete)
  num_count.delete(selected_num)

  return [num_count, us_nums, num_costs]
end

def take_outer_nums?(us_nums, num_count)
  return false if us_nums != [us_nums[1]-1, us_nums[1], us_nums[1]+1]

  # In a 3 element array, if selecting the
  if (us_nums[0]*num_count[us_nums[0]] + us_nums[2]*num_count[us_nums[2]]) <= (us_nums[1]*num_count[us_nums[1]])
    return false
  end

  return true
end

def delete_and_earn(nums)
  p nums.sort.uniq
  continuous_subsets = divide_into_cont_subsets(nums)

  pt_total = 0
  continuous_subsets.each do |subset|
    p subset
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


# p delete_and_earn(a)
# p delete_and_earn(b)
# p delete_and_earn(c)
# p delete_and_earn(d)
# p delete_and_earn(g)
p delete_and_earn(h)
