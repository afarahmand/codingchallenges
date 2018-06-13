# @param {String} j
# @param {String} s
# @return {Integer}
def num_jewels_in_stones(j, s)
    count = 0
    s.chars.each do |stone|
        count+=1 if j.chars.include?(stone)
    end

    count
end
