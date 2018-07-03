# @param {Integer[][]} a
# @return {Integer[][]}
def flip_and_invert_image(a)
    a.map do |row|
      row.map{ |el| el == 0 ? 1 : 0}.reverse
    end
end
