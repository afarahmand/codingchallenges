/**
 * @param {number[][]} matrix
 * @return {boolean}
 */

const doesDiagonalHaveIdenticalNums = (matrix, startingPos) => {
  let currentPos = startingPos;
  let num = matrix[startingPos[0]][startingPos[1]]

  while (currentPos[0] < matrix.length && currentPos[1] < matrix[0].length) {
    if (matrix[currentPos[0]][currentPos[1]] !== num) { return false; }
    currentPos = [currentPos[0]+1, currentPos[1]+1];
  }

  return true;
}

var isToeplitzMatrix = function(matrix) {
  let currentPos = [matrix.length-1, 0];
  while (currentPos[0] >= 0) {
    if (!doesDiagonalHaveIdenticalNums(matrix, currentPos)) { return false; }
    currentPos[0]--;
  }

  currentPos = [0, 1];
  while (currentPos[1] < matrix[0].length) {
    if (!doesDiagonalHaveIdenticalNums(matrix, currentPos)) { return false; }
    currentPos[1]++;
  }

  return true;
};
