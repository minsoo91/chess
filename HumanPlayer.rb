require 'colorize'

class HumanPlayer
  attr_reader :color, :board

  class EmptySquareError < ArgumentError
  end

  class OpponentPieceError < ArgumentError
  end

  def initialize(color, board)
    @color = color
    @board = board
  end

  def play_turn
    begin
      start = set_start_pos
    rescue EmptySquareError
      puts "You cannot select an empty space!"
      retry
    rescue OpponentPieceError
      puts "You must pick your own piece"
      retry
    rescue TypeError
      puts "Please put the correct input"
      retry
    rescue ArgumentError
      puts "Make sure you use a letter and then a digit"
      retry
    end
    begin
      ending = set_end_pos
      board.move(start, ending)
    rescue MovingtoCheckError
      puts "You're in check!"
      play_turn
    rescue StupidMoveError
      puts "That is an invalid move for that piece!"
      play_turn
    rescue TypeError
      puts "Please put the correct input"
      play_turn
    rescue ArgumentError
      puts "Make sure you use a letter and then a digit"
      play_turn
    end
  end

  def color_sym_to_s
    color == :w ? "White" : "Black"
  end

  def set_start_pos
    puts "#{color_sym_to_s.colorize(:blue)}'s turn: Pick a piece to move (i.e. h7)"
    start_pos = gets.chomp.split('')
    start_pos = [parse_input(start_pos[0]), Integer(start_pos[1]) - 1]

    if board[start_pos].nil?
      raise EmptySquareError
    end

    if board[start_pos].color != color
      raise OpponentPieceError
    end
    start_pos
  end

  def set_end_pos
    puts "Where do you want to move your piece (i.e. h5)"
    end_pos = gets.chomp.split('')
    end_pos = [parse_input(end_pos[0]), Integer(end_pos[1]) - 1]
  end

  def parse_input(letter)
    input_hash = { 'a' => 0,
                   'b' => 1,
                   'c' => 2,
                   'd' => 3,
                   'e' => 4,
                   'f' => 5,
                   'g' => 6,
                   'h' => 7
    }
    input_hash[letter]
  end
end

