/**
 * Definition for binary tree with next pointer.
 * function TreeLinkNode(val) {
 *     this.val = val;
 *     this.left = this.right = this.next = null;
 * }
 */

/**
 * @param {TreeLinkNode} root
 * @return {void} Do not return anything, modify tree in-place instead.
 */

const setNext = (node, parent = null, isLeft) => {
  if (isLeft) {
    node.next = parent.right;
  } else {
    if (parent.next !== null) {
      node.next = parent.next.left;
    }
  }

  // Has children
  if (node.left !== null) {
    parent = node;
    setNext(node.left, parent, true);
    setNext(node.right, parent, false);
  }
};

var connect = function(root) {
  // Has children
  if (root !== null && root.left !== null) {
    let parent = root;
    setNext(root.left, parent, true);
    setNext(root.right, parent, false);
  }
};
