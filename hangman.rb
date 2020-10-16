# frozen_string_literal: false

require 'pry'

class Game
  attr_reader :guess #, :dictionary

  DICTIONARY_REGEX = /\r\n([a-zA-Z]{5,12})\r\n/.freeze # only 5-12 character words
  DICTIONARY_FILE = 'dictionary.txt'.freeze

  def initialize
    @remaining_guess_counter = 6
    # create_dictionary
    get_random_secret_word
    @board = Board.new(secret_word)
  end

  def play
    while @remaining_guess_counter > 0
      puts @board.gameboard[0].join #troubleshooting only
      puts "#{remaining_guess_counter} incorrect guesses remaining."
      puts "incorrect guesses: #{@board.incorrect_guesses.uniq.join('-')}"
      get_player_guess
      if guess == '-'
        puts 'Invalid input. Please choose a valid letter.'
        next
      else
        @board.check_guess(guess)
      end
      self.remaining_guess_counter = 6 - @board.incorrect_guesses.uniq.length 
        # THE IMPORTANCE OF SELF HERE SO PROGRAM DOESN'T THINK MAKING A QUICK LOCAL VARIABLE
      show_board_status
      # game_won? ? (puts "Congrats, you've guessed the word!") : nil
      exit if game_won? || game_lost?
    end
  end

  # def create_dictionary
    # @dictionary = File.read(Game::DICTIONARY_FILE).scan(Game::DICTIONARY_REGEX).flatten
  def get_random_secret_word
    @secret_word = File.read(Game::DICTIONARY_FILE).scan(Game::DICTIONARY_REGEX).flatten.sample
  end

  # def get_random_secret_word # add sample to File.read dictionary method to condense?
  #   @secret_word = dictionary.sample
  # end

  def get_player_guess
    puts 'Guess a letter that has not been chosen yet:'
    @input = gets.chomp.downcase
    @guess = input.match(/[a-z]/) && input.length == 1 ? input : '-'
    #binding.pry
  end

  def show_board_status
    puts @board.gameboard[1].join(' ')
  end

  def game_won?
    if @board.gameboard[1].all? { |n| n.match(/[a-z]/) }
      puts "Congrats, you've guessed the word!"
      true
    else
      false
    end
  end

  def game_lost?
    if remaining_guess_counter.zero?
      puts "Sorry, you're out of guesses. The word was #{@board.gameboard[0].join('-')}"
    else false
    end
  end

  private

  attr_reader :secret_word, :input
  attr_accessor :remaining_guess_counter
end

# Board comment
class Board
  # call @board to see all the variables or use attr_reader to call var directly

  def initialize(secret_word)
    @gameboard = Array.new(2) { Array.new(secret_word.length) }
    secret_word_letters(secret_word)
    add_secret_word_to_board
    gameboard[1].map! { '_' } # set guess/display row to show 'blank spaces'
    # change line above to have the @ so more obvious it's same as above?
    @incorrect_guesses = []
  end

  def secret_word_letters(secret_word)
    @letters = secret_word.split('')
  end

  def add_secret_word_to_board
    (0..letters.length - 1).each do |index|
      gameboard[0][index] = letters[index]
    end
  end

  def check_guess(letter)
    @indices = gameboard[0].each_index.select { |i| gameboard[0][i].downcase == letter }
      if @indices.empty?
        incorrect_guesses << letter
        puts 'Sorry, the secret word does not contain that letter'
      else 
        @indices.each do |index|
          gameboard[1][index] = gameboard[0][index] # letter
        end
        puts 'Good guess!'
      end
  end

  #private

  attr_reader :letters, :indices
  attr_accessor :gameboard, :incorrect_guesses
end

current_game = Game.new
current_game.play

# lezioni
# PRY!!!
# dont have to use @dictionary here if using attr_reader etc, because now calling the method:
    # def get_random_secret_word
    #   @secret_word = dictionary.sample
    # end
  # private vs non-private attr_ getter/setter methods
# when better to use getter/setters vs having the @/instance variable itself for clarity?