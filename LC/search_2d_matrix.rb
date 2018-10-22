def get_row_index(matrix, target, lower_bound, upper_bound)
  mid_index = (upper_bound + 1 - lower_bound)/2 + lower_bound

  # Check to see if correct row
  return mid_index if matrix[mid_index][0] <= target && matrix[mid_index][-1] >= target

  if target < matrix[mid_index][0]
    return get_row_index(matrix, target, lower_bound, mid_index - 1)
  else
    return get_row_index(matrix, target, mid_index + 1, upper_bound)
  end
end

def binary_search(arr, target)
  return false if arr.empty?
  return false if arr.length == 1 && arr[0] != target
  mid_index = arr.length/2

  if arr[mid_index] == target
    return true
  elsif arr[mid_index] < target
    return binary_search(arr[mid_index+1..-1], target)
  else
    return binary_search(arr[0..mid_index-1], target)
  end
end

def search_matrix(matrix, target)
  return false if matrix.length < 1
  row_index = get_row_index(matrix, target, 0, matrix.length - 1)
  binary_search(matrix[row_index], target)
end
