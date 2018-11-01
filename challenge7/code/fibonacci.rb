class Fibonacci
  # Implement a method that will calculate the Nth number of the Fibonacci
  # sequence (http://en.wikipedia.org/wiki/Fibonacci_number)
  def self.calculate(n)
    return 0 if n == 0
    return 1 if n == 1

    fib_num = {
      0 => 0,
      1 => 1
    }

    # Use a bottom-up dynamic programming approach to solve
    i = 2
    while i <= n
      fib_num[i] = fib_num[i-1] + fib_num[i-2]
      i+=1
    end

    fib_num[n]
  end
end
