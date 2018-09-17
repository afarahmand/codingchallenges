# @param {Integer[]} a
# @return {Integer[]}
def sort_array_by_parity(a)
  a.select{ |el| el.even? }.concat(a.select{ |el| el.odd? })
end
