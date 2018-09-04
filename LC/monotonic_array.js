/**
 * @param {number[]} A
 * @return {boolean}
 */

var isMonotonic = function(A) {
  if (A.length < 2) { return true; }

  let lastNum = A[0];
  let i = 1;
  while (i < A.length) {
    if (A[i] < lastNum) { break; }
    lastNum = A[i];
    i++;
  }

  if (i === A.length) { return true; }

  lastNum = A[0];
  i = 1;
  while (i < A.length) {
    if (A[i] > lastNum) { return false; }
    lastNum = A[i];
    i++;
  }

  return true;
};
