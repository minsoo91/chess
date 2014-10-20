require './pieces/piece.rb'

class SteppingPiece < Piece
  def moves
    positions = []
    pos_dup = pos.dup
    move_bounds.each do |coords|
      x = (pos_dup[0] + coords[0])
      y = (pos_dup[1] + coords[1])

      next unless Board.in_bounds?([x, y])
      next unless board[[x, y]].nil? || board[[x, y]].color != board[pos].color
      positions << [x, y]
    end
    positions
  end
end