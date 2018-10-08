def get_side_options(n, s0, k, b, m)
  side_options = [s0]

  i = 1
  while i < n
    side_options << ((k*side_options[i-1]+b) % m) + 1 + side_options[i-1]
    i+=1
  end

  side_options
end

def get_combos_count(a, row, side_options, last_matches)
  coli = last_matches - 1

  while (side_options[coli] * row) > a
    coli-=1
    return 1 if side_options[coli] == row
  end

  return coli+1
end

def wall_lengths(n, s0, k, b, m, a)
  return 0 if s0*s0 > a
  # Return number of arrangements
  side_options = get_side_options(n,s0,k,b,m)
  var_count = 0
  last_matches = side_options.length

  rowi = 0
  coli = n - 1

  side_options.each do |row|
    last_matches = get_combos_count(a, row, side_options, last_matches)
    return var_count+1 if last_matches == 1

    var_count+=(last_matches*2) - 1
  end

  var_count+1
end

# output = 6

p wall_lengths(3, 1, 1, 1, 2, 4)
