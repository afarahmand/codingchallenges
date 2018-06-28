# @param {Integer[]} fronts
# @param {Integer[]} backs
# @return {Integer}

require 'set'

def flipgame(fronts, backs)
  numbers_on_2_sided_cards = Set[]

  fronts.each_with_index do |f, idx|
    if f == backs[idx]
      numbers_on_2_sided_cards.add(f)
    end
  end

  remaining_numbers = (fronts|backs) - numbers_on_2_sided_cards.to_a

  if remaining_numbers.empty?
    return 0
  else
    return remaining_numbers.min
  end
end
