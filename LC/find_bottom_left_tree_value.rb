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

def get_bl_value(depth, node)
  return [[depth, node.val]] if node.left.nil? && node.right.nil?
  return get_bl_value(1+depth, node.left) if node.right.nil?
  return get_bl_value(1+depth, node.right) if node.left.nil?

  get_bl_value(1+depth, node.left)+get_bl_value(1+depth, node.right)
end

def find_bottom_left_value(root)
  return nil if root.nil?
  leaf_nodes = get_bl_value(0, root)

  best_node = leaf_nodes.first

  if leaf_nodes.length > 1
    leaf_nodes[1..-1].each{ |node| best_node = node if node[0] > best_node[0] } # greater depth
  end

  best_node[1]
end
