# Given a list of keywords and a list of search words, return a list of indices that indicate the beginning of sequences of adjacent keywords.
#
# Examples:
# Search list: ['hello', 'hi', 'welcome', 'greetings', 'hi', 'greetings', 'hey', 'hello']
# Keywords: ['hi', 'hey', 'greetings']
# Output: [4]
#
# Search list: ['where', 'she', 'sits', 'she', 'shines', 'and', 'where', 'she', 'shines', 'she', 'sits']
# Keywords: ['she', 'sits', 'shines']
# Output: [2, 8]
#
# Search list: ['peter', 'piper', 'picked', 'a', 'peck', 'of', 'pickled', 'peppers', 'a', 'peck', 'of', 'pickled', 'peppers', 'peter', 'piper', 'picked', 'if', 'peter', 'piper', 'picked', 'a', 'peck', 'of', 'pickled', 'peppers', 'wheres', 'the', 'peck', 'of', 'pickled', 'peppers', 'peter', 'piper', 'picked']
# Keywords: ['peter', 'picked', 'piper']
# Output: [0, 13, 17, 31]
