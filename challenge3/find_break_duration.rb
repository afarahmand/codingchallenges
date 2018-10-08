# findBreakDuration

#
# Complete the 'findBreakDuration' function below.
#
# The function is expected to return an INTEGER.
# The function accepts following parameters:
#  1. INTEGER n - number of present
#  2. INTEGER k - number rescheds
#  3. INTEGER t - integer end time for event
#  4. INTEGER_ARRAY start - integer start times
#  5. INTEGER_ARRAY finish - int end times
#

def get_break_times(t, start, finish)
  break_times = []
  i = 0
  time_idx = 0

  while i < t && time_idx < start.length
    if i < start[time_idx]
      break_times << i
    end
    i = finish[time_idx]
    time_idx+=1
  end

  break_times
end

def findBreakDuration(n, k, t, start, finish)
  max_break_duration = t - finish[-1]
  beg_break_times = get_break_times(t, start, finish)


end


n = 4
k = 2
t = 15
start = [4, 6, 7, 10]
finish = [5, 7, 8, 11]

# n = 3
# k = 2
# t = 15
# start = [0, 6, 7]
# finish = [5, 7, 8]
p findBreakDuration(n, k, t, start, finish)
