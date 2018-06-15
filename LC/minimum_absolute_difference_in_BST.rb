# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer}

def iot(node)
  result = []

  if !node.left.nil?
    result.concat(iot(node.left))
  end

  result << node.val

  if !node.right.nil?
    result.concat(iot(node.right))
  end

  result
end

def get_minimum_difference(root)
  result = iot(root)

  min_diff = (result[1] - result[0]).abs

  result[2..-1].each_with_index do |num, idx|
    if num - result[idx+1] < min_diff
      min_diff = num - result[idx+1]
    end
  end

  min_diff
end
