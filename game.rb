require './board.rb'
require './HumanPlayer.rb'
require 'colorize'

class Game

  attr_accessor :turns
  attr_reader :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1, @player2, @turns =
      HumanPlayer.new(:w, board), HumanPlayer.new(:b, board), 1
  end

  def play
    check_color = :b
    turns = 1
    system("clear")
    board.display

    until game_over? 
      
      if turns == 1
        player1.play_turn
        turns += 1
      else
        player2.play_turn
        turns -= 1
      end

      system("clear")
      turns == 1 ? check_color = :b : :w

      board.display

      if board.in_check?(check_color) && !board.checkmate?(check_color)
        puts "Check!".colorize(:red)
      end

    end
    end_game_message
  end

  def game_over?
    board.checkmate?(:w) || board.checkmate?(:b)
  end

  def end_game_message
    puts "Checkmate! Black wins!".colorize(:green) if board.checkmate?(:w)
    puts "Checkmate! White wins!".colorize(:green) if board.checkmate?(:b)
  end
end

game = Game.new
game.play

# h7 h5
# g2 g4
# h5 g4
# h2 h4
# g4 g3
# h4 h5
# g3 g2
# h5 h6
# g2 f1
# e1 f1
# g7 g5
# h6 h7