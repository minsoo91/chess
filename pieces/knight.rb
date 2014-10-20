require './pieces/stepping_pieces.rb'

class Knight < SteppingPiece
  def move_bounds
    [
        [1, 2], [2, 1],
        [2, -1], [1, -2],
        [-1, -2], [-2, -1],
        [-2, 1], [-1, 2]
    ]
  end

  def inspect
    color == :w ? "♘ " : "♞ "
  end
end