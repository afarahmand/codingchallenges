# @param {Integer[]} row
# @return {Integer}

def find_index_to_swap_with(row, target, starting_index)
  i = starting_index

  while i < row.length
    return i if row[i] == target
    i+=1
  end
end

def min_swaps_couples(row)
  swaps = 0
  target_num = nil

  i = 0
  while i < row.length
    # Replace every element in an odd index, if needed, to correspond with an element in the preceding even index
    if i.odd?
      if row[i-1].even? # is 0
        target_num = row[i-1]+1
      else # is 1
        target_num = row[i-1]-1
      end

      if row[i] != target_num
        swap_index = find_index_to_swap_with(row, target_num, i)
        row[i], row[swap_index] = row[swap_index], row[i]
        swaps+=1
      end
    end
    i+=1
  end

  swaps
end
