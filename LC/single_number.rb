# @param {Integer[]} nums
# @return {Integer}
def single_number(nums)
  el_cnt = Hash.new(0)

  nums.each do |num|
    if el_cnt[num] == 1
      el_cnt.delete(num)
    else
      el_cnt[num]+=1
    end
  end

  el_cnt.keys.pop
end
