require './pieces/piece.rb'

class SlidingPiece < Piece

  def moves

    positions = []
    pos_dup = pos.dup
    move_bounds.each do |bound|
      i = 1
      while i < 8
        x = (bound[0] * i) + pos_dup[0]
        y = (bound[1] * i) + pos_dup[1]

        break unless Board.in_bounds?([x, y])

        # break if space taken by the same color
        break unless board[[x, y]].nil? || board[[x, y]].color != color

        positions << [x, y]

        # break if space taken by different color. Grants one more space to overtake the piece
        break unless board[[x, y]].nil?

        i += 1
      end
    end

    positions
  end
end