# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {TreeNode}

def invert_tree(root)
  if root.nil?
    new_node = nil
  else
    new_node = root
    temp = root.left
    new_node.left = invert_tree(root.right)
    new_node.right = invert_tree(temp)
  end

  return new_node
end
