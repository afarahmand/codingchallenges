/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var twoSum = function(nums, target) {
    let i = 0;
    while (i < nums.length) {
        let j = 0;
        while (j < nums.length) {
            if (i !== j) {
                if (nums[i] + nums[j] === target) {
                    return [i, j];
                }
            }
            j+=1;
        }
        i+=1;
    }
};
