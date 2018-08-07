# @param {String} s
# @return {Boolean}
def is_palindrome(s)
  nonalphanumeric_removed = s.downcase.scan(/\d|[a-z]/).join
  nonalphanumeric_removed == nonalphanumeric_removed.reverse
end
