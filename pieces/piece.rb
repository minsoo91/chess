class Piece

  attr_reader :color
  attr_accessor :board, :pos

  def initialize(pos, board, color)
    @pos, @board, @color = pos, board, color
  end

  def moves
    raise "Not yet implemented!"
  end

  def move_into_check?(end_pos)
    board_dup = board.dup
    board_dup.move!(pos, end_pos)
    board_dup.in_check?(color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def inspect
  end
end