# frozen_string_literal: false
require 'pry'

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
  attr_reader :dictionary

  def initialize
    @remaining_guess_counter = 6
    create_dictionary
    get_random_secret_word
    binding.pry
  end

  def create_dictionary
    @dictionary = File.read('dictionary.txt').scan(/\r\n([a-zA-Z]{5,12})\r\n/).flatten
  end

  def get_random_secret_word
    @secret_word = dictionary.sample
  end
end

class Board
  def initialize
  end
end

current_game = Game.new
# set remaining guesses = 6 (Game)
# An array of two arrays of the same length: secret word and displayed word (Board)
# loop:
# display number of guesses remaining (starts at 6) (Game)
# ask player for a letter (Game)
# if letter is incorrect, subtract one from remaining guesses (Game)
# else add the letter to the applicable spot(s) (Board)
# display the board (Board)
# end if no guesses left or word completed (Game)

# lezioni
# PRY!!!
# dont have to use @dictionary here if using attr_reader etc, because now calling the method:
    # def get_random_secret_word
    #   @secret_word = dictionary.sample
    # end