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

  DICTIONARY_REGEX = /\r\n([a-zA-Z]{5,12})\r\n/.freeze
  DICTIONARY_FILE = 'dictionary.txt'.freeze

  def initialize
    @remaining_guess_counter = 6
    create_dictionary
    get_random_secret_word
    @board = Board.new(self.secret_word)
    binding.pry
  end

  def create_dictionary
    @dictionary = File.read(Game::DICTIONARY_FILE).scan(Game::DICTIONARY_REGEX).flatten
  end

  def get_random_secret_word # add sample to File.read dictionary method to condense
    @secret_word = dictionary.sample
  end

  private

  attr_reader :secret_word
end

# Board comment
class Board
  # call @board to see all the variables or use attr_reader to call var directly

  def initialize(secret_word)
    # @length = secret_word.length
    @game_board = Array.new(2) { Array.new(secret_word.length) }
    secret_word_letters(secret_word)
    add_secret_word_to_board
  end

  def secret_word_letters(secret_word)
    @letters = secret_word.split('')
  end

  def add_secret_word_to_board
    # below version does not work if a letter repeats in the word. less straightforward as well
    # letters.each do |letter|
    #   game_board[0][letters.index(letter)] = letter
    # end
    (0..letters.length - 1).each do |index|
      game_board[0][index] = letters[index]
    end
  end

  private

  attr_reader :letters
  attr_accessor :game_board
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