# @param {Integer[]} nums
# @return {String[]}

def construct_range(start, fin)
  return start.to_s if start == fin
  start.to_s+"->"+fin.to_s
end

def summary_ranges(nums)
  return [] if nums.empty?
  output = []
  start = nums[0]
  last_num = nums[0]

  nums.each do |num|
    if num > last_num + 1
      output << construct_range(start, last_num)
      start = num
    end

    last_num = num
  end

  # Final number is accounted for
  if !output.empty? # If all of nums falls into a single range, this condition is false
    return output if output.last[-1] == nums.last.to_s
  end

  # Otherwise account for last range
  output << construct_range(start, last_num)
  output
end
