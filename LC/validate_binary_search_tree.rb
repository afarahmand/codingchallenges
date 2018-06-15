# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Boolean}

def iot(root)
  result = []

  if !root.left.nil?
    result.concat(iot(root.left))
  end

  result << root.val

  if !root.right.nil?
    result.concat(iot(root.right))
  end

  result
end

def is_valid_bst(root)
  return true if root.nil?

  result = iot(root)

  return false if result.sort != result.uniq.sort
  result == result.sort
end
