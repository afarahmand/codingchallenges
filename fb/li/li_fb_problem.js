var checkSubarraySum = function(nums, k) {
  let targets = {};
  let runningSum = 0;

  let i = 0;
  while (i < nums.length) {
    runningSum+=nums[i];
    targets[runningSum+k] = true;

    // console.log(runningSum);
    // console.log(nums[i]);
    // console.log(Object.keys(targets));

    if (targets[runningSum]) return true;
    i++;
  }

  return false;
};

console.log(checkSubarraySum([23, 2, 4, 6, 7], 6));
// console.log("---");
// console.log(checkSubarraySum([23, 2, 6, 4, 7], 6));
// console.log(checkSubarraySum([23,2,4,6,7], -6));
