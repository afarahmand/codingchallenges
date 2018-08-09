# @param {Integer} n
# @return {Integer}

def find_best_multiplicands(num)
  if num < 5
    return [1, 1] if num == 2
    return [2, 1] if num == 3
    return [2, 2] if num == 4
  end

  comb = []
  total = num
  while total > 4
    comb << 3
    total-=3
  end

  comb << total

  comb
end

def integer_break(n)
  find_best_multiplicands(n).inject(:*)
end
