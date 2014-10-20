require './pieces/piece.rb'

class BadTransformError < ArgumentError
end

class Pawn < Piece

  attr_accessor :first_move

  def initialize(pos, board, color)
    @first_move = true
    super
  end

  def moves
    forward_steps + side_attacks
  end

  def forward_dir
    (color == white) ? -1 : 1
  end

  def at_start_row?
    pos[1] == ((color == :w) ? 6 : 1)
  end

  def forward_steps
    positions = []
    pos_dup = pos.dup
    direction = color == :w ? -1 : 1
    x = pos_dup[0]
    y = pos_dup[1] + direction

    if Board.in_bounds?([x, y]) && board[[x, y]].nil?
      positions << [x, y]
    end

    positions << [x, y + direction] if at_start_row? && board[[x, y + direction]].nil?
    

    positions
  end

  def side_attacks

    positions = []
    pos_dup = pos.dup
    direction = color == :w ? -1 : 1
    x = pos_dup[0]
    y = pos_dup[1] + direction

    diags = [[x - 1, y], [x + 1, y]]

    diags.each do |diag|
      positions << diag unless board[diag].nil? || board[diag].color == color
    end

    positions
  end

  def inspect
    color == :w ? "♙ " : "♟ "
  end

  def transform
    puts "Pick a piece: #{piece_list} (q or b or r or k)"
    input = gets.chomp
    raise BadTransformError unless %w(q b r k).include?(input)
    board[pos] = piece_list[input]
  end

  def piece_list
    { 'q' => Queen.new(pos, board, color),
      'b' => Bishop.new(pos, board, color),
      'r' => Rook.new(pos, board, color),
      'k' => Knight.new(pos, board, color)
     }
  end

end