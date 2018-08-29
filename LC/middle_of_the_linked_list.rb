# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# @param {ListNode} head
# @return {ListNode}
def middle_node(head)
  ll_len = 0
  current_node = head

  while !current_node.nil?
    current_node = current_node.next
    ll_len+=1
  end

  i=0
  current_node = head
  while i < (ll_len/2)
    current_node = current_node.next
    i+=1
  end

  current_node
end
