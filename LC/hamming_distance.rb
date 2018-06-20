# @param {Integer} x
# @param {Integer} y
# @return {Integer}

def conv_to_bin(num)
  num.to_s(2)
end

def hamming_distance(x, y)
  conv_to_bin(x^y).count("1")
end
