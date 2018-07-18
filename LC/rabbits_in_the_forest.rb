# @param {Integer[]} answers
# @return {Integer}

def num_rabbits(answers)
  return 0 if answers.empty?

  uniq_nums = answers.uniq
  nums_count = {}
  number_of_rabbits = 0

  uniq_nums.each do |num|
    nums_count[num] = answers.count(num)
  end

  p nums_count

  nums_count.each do |k, v|
    number_of_rabbits+=(k+1)*(v.to_f/(k+1)).ceil
  end

  number_of_rabbits
end
