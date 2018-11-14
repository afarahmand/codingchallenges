# @param {Integer[]} nums
# @return {Boolean}

def cost(arr)
  return nil if arr.length < 2
  return arr if arr.length == 2

  cost = [nil, nil]

  # left cost
  cost[0] = arr[0] - arr[1]
  cost[1] = arr[-1] - arr[-2]

  return cost if cost[0] != cost[1]

  if arr.length > 5
    return cost(arr[2..-3])
  elsif arr[0] == arr[-1]
    cost[0]+=1
    return cost
  else
    return [arr[0], arr[-1]]
  end
end

def predict_the_winner(nums)
  p1score = 0
  p2score = 0
  p1turn = true

  until nums.empty?
    # print  "nums: "
    # p nums

    if p1turn
      if nums.length > 1
        cost = cost(nums)
        cost[1] > cost[0] ? p1score+=nums.pop : p1score+=nums.shift
      else
        p1score+=nums.pop
      end

      p1turn = false
    else
      if nums.length > 1
        cost = cost(nums)
        cost[1] > cost[0] ? p2score+=nums.pop : p2score+=nums.shift
      else
        p2score+=nums.pop
      end

      p1turn = true
    end

    # print "Player 1: ", p1score, " | Player 2: "
    # p p2score
  end

  # return [p1score, p2score]
  return p1score >= p2score
end

# Is player 1 the winner?
a = [3606449,6,5,9,452429,7,9580316,9857582,8514433,9,6,6614512,753594,5474165,4,2697293,8,7,1]
b = [30000,1,1,1,4000,1,90000,90000,80000,1,1,60000,7000,50000,1,20000,1,1,1]
# b should be true
p predict_the_winner(b)





# # @param {Integer[]} nums
# # @return {Boolean}
#
# def cost(arr)
#   return true if arr.length < 3
#
#   dp = {}
#   dp[0] = [num[0], 0]
#   dp[1] = [[num[0], num[1]].max, [num[0], num[1]].min]
#
#   arr[2..-1].each_with_index do |num, idx|
#     dp[idx+2] =
#   end
# end
#
# # Is player 1 the winner?
# a = [3606449,6,5,9,452429,7,9580316,9857582,8514433,9,6,6614512,753594,5474165,4,2697293,8,7,1]
# p predict_the_winner(a)
