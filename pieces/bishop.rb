# encoding: UTF-8

require './pieces/sliding_pieces.rb'

class Bishop < SlidingPiece
  def move_bounds
    [[1, 1], [-1, -1], [1, -1], [-1, 1]]
  end

  def inspect
    color == :w ? "♗ " : "♝ "
  end
end