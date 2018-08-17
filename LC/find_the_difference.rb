# @param {String} s
# @param {String} t
# @return {Character}
def find_the_difference(s, t)
  xor_sum = 0
  s.each_char{ |char| xor_sum^=char.ord }
  t.each_char{ |char| xor_sum^=char.ord }
  xor_sum.chr
end
