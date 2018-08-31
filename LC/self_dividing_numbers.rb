# @param {Integer} left
# @param {Integer} right
# @return {Integer[]}
def self_dividing_number?(num)
  uniq_digit_arr = num.to_s.chars.uniq
  return false if uniq_digit_arr.include?("0")
  return false if uniq_digit_arr.include?("2") && num.odd?
  return false if uniq_digit_arr.include?("5") && num.to_s[-1] != "5"

  uniq_digit_arr-=["2","5"]

  uniq_digit_arr.each do |digit|
    return false if num%digit.to_i != 0
  end

  true
end

def self_dividing_numbers(left, right)
  result = []
  i = left

  # All single digit numbers except 0 are self-dividing-numbers
  if left < 10
    result = (left..9).to_a
    i = 11
  end

  while i <= right
    result << i if self_dividing_number?(i)
    i+=1
  end

  result
end
