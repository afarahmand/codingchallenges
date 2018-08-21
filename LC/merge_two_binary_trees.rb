# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} t1
# @param {TreeNode} t2
# @return {TreeNode}

def merge_trees(t1, t2)
  if t1.nil? && t2.nil?
    return nil
  elsif t1.nil?
    new_tree = TreeNode.new(t2.val)
    new_tree.left = t2.left
    new_tree.right = t2.right
  elsif t2.nil?
    new_tree = TreeNode.new(t1.val)
    new_tree.left = t1.left
    new_tree.right = t1.right
  else
    new_tree = TreeNode.new(t1.val+t2.val)
    new_tree.left = merge_trees(t1.left, t2.left)
    new_tree.right = merge_trees(t1.right, t2.right)
  end

  new_tree
end
