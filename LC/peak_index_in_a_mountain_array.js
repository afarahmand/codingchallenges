/**
 * @param {number[]} A
 * @return {number}
 */
var peakIndexInMountainArray = function(A) {
  let peakIndex = 0, peakHeight = A[0];
  let i = 1;

  while (i < (A.length - 1)) {
    if (A[i] > peakHeight) {
      peakHeight = A[i];
      peakIndex = i;
    }
    i++;
  }

  return peakIndex;
};
