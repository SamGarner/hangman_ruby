# frozen_string_literal: false

# Load a word between 5-12 letters long as the secret word (Game)
# set remaining guesses = 6 (Game)
# An array of two arrays of the same length: secret word and displayed word (Board)
# loop:
# display number of guesses remaining (starts at 6) (Game)
# ask player for a letter (Game)
# if letter is incorrect, subtract one from remaining guesses (Game)
# else add the letter to the applicable spot(s) (Board)
# display the board (Board)
# end if no guesses left or word completed (Game)

# Load a word between 5-12 letters long as the secret word (Game)
class Game

  def create_dictionary
    @dictionary = File.read('dictionary.txt').scan(/\r\n([a-zA-Z]{5,12})\r\n/).flatten
  end
end
# set remaining guesses = 6 (Game)
# An array of two arrays of the same length: secret word and displayed word (Board)
# loop:
# display number of guesses remaining (starts at 6) (Game)
# ask player for a letter (Game)
# if letter is incorrect, subtract one from remaining guesses (Game)
# else add the letter to the applicable spot(s) (Board)
# display the board (Board)
# end if no guesses left or word completed (Game)