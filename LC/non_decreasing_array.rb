# @param {Integer[]} nums
# @return {Boolean}

def nda?(arr)
    i = 1
    while i < arr.length
        return false if arr[i] < arr[i-1]
        i+=1
    end

    true
end

def resolvable_mismatch?(nums, i)
    arr = nums.dup

    arr[i] = arr[i-1]

    return true if nda?(arr)

    arr = nums.dup
    arr[i-1] = arr[i]

    return true if nda?(arr)
    false
end

def check_possibility(nums)
    return true if nums.length < 2

    count = 0

    i = 1
    while i < nums.length
        if nums[i] < nums[i-1]
            if count == 0 && resolvable_mismatch?(nums, i)
                count+=1
            else
                return false
            end
        end

        i+=1
    end

    true
end
