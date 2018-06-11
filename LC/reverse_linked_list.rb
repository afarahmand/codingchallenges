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

# 1, 2, 3, 4


def reverse_list(head)
    return [] if head.nil?
    return head if head.next.nil?

    prev_node = head
    current_node = prev_node.next
    next_node = current_node.next

    head.next = nil
    current_node.next = prev_node

    until next_node.nil?
        prev_node = current_node
        current_node = next_node
        next_node = next_node.next

        current_node.next = prev_node
    end

    return current_node
end
