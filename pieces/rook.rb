require './pieces/sliding_pieces.rb'

class Rook < SlidingPiece
  def move_bounds
    [[1, 0], [0, 1], [-1, 0], [0, -1]]
  end

  def inspect
    color == :w ? "♖ " : "♜ "
  end
end

