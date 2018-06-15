# @param {Integer} n
# @return {String[]}
def fizz_buzz(n)
    result = []
    (1..n).to_a.each do |num|
      if num % 3 == 0 && num % 5 == 0
        result << "FizzBuzz"
      elsif num%3 == 0
        result << "Fizz"
      elsif num%5 == 0
        result << "Buzz"
      else
        result << num.to_s
      end
    end

  result
end
