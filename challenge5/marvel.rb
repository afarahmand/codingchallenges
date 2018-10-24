# require 'digest/md5'
require 'net/http'
require 'json'

# a precomputed MD5 hash generated from the summation of a timestamp (=1), public, and private keys
HASH = '<REDACTED>'
PUBLIC_KEY = '<REDACTED>'
BASE_URL = 'http://gateway.marvel.com/v1/public/characters'

def display_intro_message
  p "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  p "                  Welcome to the Marvel Combat Arena!!!                    "
  p "              (All data provided by Marvel. © 2018 MARVEL)                 "
  p "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
  p "                                                                           "
end

def prompt_user_for_name(order)
  print 'Enter the name of the ' + order + ' contender: '
  gets.chomp
end

def fetch_marvel_character(name)
  params = "?apikey=#{PUBLIC_KEY}&hash=#{HASH}&ts=1&name=#{name}"
  url = BASE_URL + params

  uri = URI(url)
  response = Net::HTTP.get(uri)
  json = JSON.parse(response)

  # User inputted name is not a valid Marvel character
  return nil if json["data"]["count"] != 1

  {
    "name" => json["data"]["results"][0]["name"],
    "description" => json["data"]["results"][0]["description"]
  }
end

def get_character(order)
  name = ' '
  character = nil

  until character
    name = prompt_user_for_name(order)

    until name.length > 0
      p "ERROR!: Invalid entry.  Name must have length greater than 0.  Please try again."
      name = prompt_user_for_name(order)
    end

    character = fetch_marvel_character(name)

    if !character
      p "ERROR!: There is no Marvel character named " + name + ".  Please try again."
    end
  end

  character
end

def resolve_duplicate_character(character1, character2)
  until character2 != character1
    p "#{character1["name"]} ERUPTS in LAUGHTER at your PITIful attempt to encourage self-fighting!!!"
    sleep(2)
    p "The arena crowd taunts you as you proceed to make another selection..."
    sleep(2)
    character2 = get_character("second")
  end

  character2
end

def valid_seed_range?(seed)
  seed > 0 && seed < 10
end

def get_seed
  seed = 0

  until valid_seed_range?(seed)
    print 'Enter a seed value in the range [1-9]: '
    seed = gets.chomp.to_i

    p "ERROR!: Seed value outside valid range." if !valid_seed_range?(seed)
  end

  seed
end

def extract_seed_word_from_character(character, seed)
  # p character["description"]

  # Account for when the seed is greater than the number of words in the description
  word = character["description"].split(" ")[seed - 1]
  return "" if word.nil?
  word
end

def is_magic_word?(word)
  word == 'gamma' || word == 'radioactive'
end

def get_battle_result(character1, character2, seed)
  word1 = extract_seed_word_from_character(character1, seed)
  word2 = extract_seed_word_from_character(character2, seed)

  # p "word1: " + word1
  # p "word2: " + word2

  # Check to see if 'Radioactive' or 'Gamma' included
  # In the marvel character descriptions, the word gamma is sometimes
  #   capitalized and sometimes uncapitalized.  Radioactive is only
  #   in 2 character descriptions always uncapitalized.
  if is_magic_word?(word1) && is_magic_word?(word2)
    return 0
  elsif is_magic_word?(word1)
    return 1
  elsif is_magic_word?(word2)
    return 2
  end

  return 0 if word1.length == word2.length
  return 1 if word1.length > word2.length
  return 2
end

def output_battle_result(character1, character2, battle_result)
  if battle_result == 0
    p "An epic battle between #{character1["name"]} and #{character2["name"]} resulted in a tie."
  elsif battle_result == 1
    p "#{character1["name"]} conquered #{character2["name"]}."
  else
    p "#{character2["name"]} vanquished #{character1["name"]}."
  end
end

def continue_game?
  input = ''

  p " "
  print 'Would you like to play again? [y/n]: '
  input = gets.chomp

  return true if input == 'y' || input == 'yes'
  false
end

def battle
  continue_game = true

  while continue_game
    system "clear"
    display_intro_message()
    character1 = get_character("first")
    character2 = get_character("second")
    character2 = resolve_duplicate_character(character1, character2) if character2 == character1

    seed = get_seed
    p " "

    battle_result = get_battle_result(character1, character2, seed)
    output_battle_result(character1, character2, battle_result)

    continue_game = continue_game?()
  end

  p "Thanks for playing! Good bye!"
end

battle()
