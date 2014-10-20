#TODO: ADD BOARD AND COLOR BACK TO THE INITIALIZE

require './pieces/stepping_pieces.rb'

class King < SteppingPiece
  def move_bounds
    [
        [1, 0], [1, 1],
        [0, 1], [-1, 0],
        [-1, 1], [0, -1],
        [-1, -1], [1, -1]
    ]
  end

  def inspect
    color == :w ? "♔ " : "♚ "
  end
end