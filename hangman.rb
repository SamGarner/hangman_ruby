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
  attr_reader :dictionary, :guess

  DICTIONARY_REGEX = /\r\n([a-zA-Z]{5,12})\r\n/.freeze
  DICTIONARY_FILE = 'dictionary.txt'.freeze

  def initialize
    @remaining_guess_counter = 6
    create_dictionary
    get_random_secret_word
    @board = Board.new(self.secret_word)
    #binding.pry
  end

  def play
    while @remaining_guess_counter > 0
      puts @board.gameboard[0].join() #troubleshooting only
      # puts @board.incorrect_guesses.inspect
      puts @board.gameboard[1].join()
      # puts remaining_guess_counter.inspect
      # puts @remaining_guess_counter.inspect
      puts " #{remaining_guess_counter} incorrect guesses remaining."
      puts "incorrect guesses: #{@board.incorrect_guesses.join('-')}"
      get_player_guess
      # puts 'guess inspect'
      # puts guess.inspect
      if guess == '-'
        puts 'Invalid input. Please choose a valid letter.'
        next
      else
      # next unless guess != '-'
        @board.check_guess(guess)
      end
      self.remaining_guess_counter = 6 - @board.incorrect_guesses.uniq.length 
        # THE IMPORTANCE OF SELF HERE SO PROGRAM DOESN'T THINK MAKING A QUICK LOCAL VARIABLE
      # p remaining_guess_counter
      # p @remaining_guess_counter
      # binding.pry
      show_board_status
      # game_won? ? (puts "Congrats, you've guessed #{@board.gameboard[0].join()} correctly!") : next
      # game_won? ? (puts "Congrats, you've guessed the word!") : nil
      # game_lost?
      exit if game_won? || game_lost?
      # binding.pry
    end
  end

  def create_dictionary
    @dictionary = File.read(Game::DICTIONARY_FILE).scan(Game::DICTIONARY_REGEX).flatten
  end

  def get_random_secret_word # add sample to File.read dictionary method to condense
    @secret_word = dictionary.sample
  end

  def get_player_guess
    puts 'Guess a letter that has not been chosen yet:'
    @input = gets.chomp.downcase
    # puts 'input inspect:'
    # puts @input.inspect
    @guess = input.match(/[a-z]/) && input.length == 1 ? input : '-'
    #binding.pry
  end

  def show_board_status
    puts @board.gameboard[1].join(' ')
  end

  def game_won?
    if @board.gameboard[1].all? { |n| n.match /[a-z]/ }
      puts "Congrats, you've guessed the word!"
      true
    else
      false
    end
  end

  def game_lost?
    # puts "not working"
    # puts remaining_guess_counter
    # p remaining_guess_counter.zero?
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
    # @length = secret_word.length
    @gameboard = Array.new(2) { Array.new(secret_word.length) }
    secret_word_letters(secret_word)
    add_secret_word_to_board
    self.gameboard[1].map! { '_' } # set guess/display row to show 'blank spaces'
    # change line above to have the @ so more obvious it's same as above?
    @incorrect_guesses = []
  end

  def secret_word_letters(secret_word)
    @letters = secret_word.split('')
  end

  def add_secret_word_to_board
    # below version does not work if a letter repeats in the word. less straightforward as well
    # letters.each do |letter|
    #   gameboard[0][letters.index(letter)] = letter
    # end
    (0..letters.length - 1).each do |index|
      gameboard[0][index] = letters[index]
    end
  end

  def check_guess(letter)
    @indices = gameboard[0].each_index.select { |i| gameboard[0][i] == letter }
      if @indices.empty?
        incorrect_guesses << letter
        puts 'Sorry, the secret word does not contain that letter'
      else 
        @indices.each do |index|
          gameboard[1][index] = letter
        end
        puts 'Good guess!'
      end
    # binding.pry
  end

  # comparing input against secret word - count to get the number of occurences then loop using .index/each_index to replace?
  # e.g. arr = ['x', 'o', 'x', '.', '.', 'o', 'x']
    #  p arr.each_index.select{|i| arr[i] == 'x'} # =>[0, 2, 6]

  #private

  attr_reader :letters, :indices
  attr_accessor :gameboard, :incorrect_guesses
end

current_game = Game.new
current_game.play
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
  # priave vs non-private attr_ getter/setter methods