# Choose between alternative forms of a phrase
def replace_str(input)
    # Remove opening and closing brackets from input
    input = input.slice(1, input.length - 2)

    # Use split method to create array, where each element is different option, then choose random element
    input.split("|").sample
end

def rand_sentence(input)
    output = ""
    substrings = []

    input.chars.each_with_index do |char, idx|
        if char == "{"
            substrings.push(char)
        elsif char == "}"
            # Concat closing bracket
            substrings[-1]+=char

            if substrings.length == 1
                output+=replace_str(substrings.pop)
            else
                temp = replace_str(substrings.pop)
                substrings[-1]+=temp
            end
        elsif !substrings.empty?
            substrings[substrings.length]+=char
        elsif substrings.empty?
            output+=char
        end
    end

    output
end

# Testing via Ruby interpreter now...
# The single layer alternatives work but it still fails for multi-layered brackets :(
# More debugging...
# Most recent change solves many of the multi-layered brackets.  However, sometimes we still get "great|awesome" invalidly returned
# Issue appears to be somewhere in the helper function, probably with partitioning
# Replaced partition method with split method

#test1 = "{I am|I'm} {working on|starting} this {online |}interview. I hope my fav company thinks I am
# {{very|extremely} qualified|great|awesome}{!|.}"
#p rand_sentence(test1)
