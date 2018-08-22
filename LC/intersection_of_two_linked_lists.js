/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} headA
 * @param {ListNode} headB
 * @return {ListNode}
 */

const getLLNodeCount = LL => {
  let nodeCount = 1;
  let currentNode = LL;

  while (currentNode !== null) {
    nodeCount++;
    currentNode = currentNode.next;
  }

  return nodeCount;
};

const getStartNodes = (headA, countA, headB, countB) => {
  if (countA === countB) {
    return [headA, headB];
  }

  let currentNode;
  if (countA > countB) {
    currentNode = headA;
    while (countA > countB) {
      countA--;
      currentNode = currentNode.next;
    }

    return [currentNode, headB];
  } else if (countA < countB) {
    currentNode = headB;
    while (countA < countB) {
      countB--;
      currentNode = currentNode.next;
    }

    return [headA, currentNode];
  }
};

const getIntersectingNode = (currentNodeA, currentNodeB) => {
  while (currentNodeA !== null) {
    if (currentNodeA === currentNodeB) {
      return currentNodeA;
    }

    currentNodeA = currentNodeA.next;
    currentNodeB = currentNodeB.next;
  }

  return null;
};

var getIntersectionNode = function(headA, headB) {
  if ((headA === null) || (headB === null)) {
    return null;
  }

  let countA = getLLNodeCount(headA);
  let countB = getLLNodeCount(headB);

  // Find starting nodes
  let startA, startB;
  [startA, startB] = getStartNodes(headA, countA, headB, countB);

  // Find intersection node
  let intersectionNode;
  return getIntersectingNode(startA, startB);
};
