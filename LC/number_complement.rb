# @param {Integer} num
# @return {Integer}
def find_complement(num)
  all_ones = ""
  num.to_s(2).length.times{ all_ones+="1" }
  num^all_ones.to_i(2)
end
