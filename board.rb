# encoding: UTF-8
require 'colorize'
require './pieces.rb'
require 'debugger'

class NilPieceError < ArgumentError
end

class MovingtoCheckError < ArgumentError
end

class StupidMoveError < ArgumentError
end

class Board
  attr_accessor :rows

  attr_reader :pieces_eaten

  def initialize(populate = true)
    @rows = Array.new(8) { Array.new(8) }
    populate_board if populate
    @pieces_eaten = []
  end

  def self.in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def populate_board
    self[[0,0]] = Rook.new([0,0], self, :b)
    self[[1,0]] = Knight.new([1,0], self, :b)
    self[[2,0]] = Bishop.new([2,0], self, :b)
    self[[3,0]] = Queen.new([3,0], self, :b)
    self[[4,0]] = King.new([4,0], self, :b)
    self[[5,0]] = Bishop.new([5,0], self, :b)
    self[[6,0]] = Knight.new([6,0], self, :b)
    self[[7,0]] = Rook.new([7,0], self, :b)

    self[[0,7]] = Rook.new([0,7], self, :w)
    self[[1,7]] = Knight.new([1,7], self, :w)
    self[[2,7]] = Bishop.new([2,7], self, :w)
    self[[3,7]] = Queen.new([3,7], self, :w)
    self[[4,7]] = King.new([4,7], self, :w)
    self[[5,7]] = Bishop.new([5,7], self, :w)
    self[[6,7]] = Knight.new([6,7], self, :w)
    self[[7,7]] = Rook.new([7,7], self, :w)

    (0..7).each do |i|
      self[[i, 1]] = Pawn.new([i,1], self, :b)
      self[[i, 6]] = Pawn.new([i,6], self, :w)
    end

  end

  def [](pos)
    x, y = pos
    @rows[y][x]
  end

  def []=(pos, piece)
    x, y = pos
    @rows[y][x] = piece
  end

  def display
    color = :light_white
    print "  "
    ('a'..'h').each { |letter| print "#{letter} " }
    puts ""
    rows.each_index do |row|
      print "#{row + 1} "
      color = colorz(color)
      rows.each_index do |col|
        color = colorz(color)

        if self.rows[row][col] == nil
          print "  ".colorize(:background => color)
        else
          print "#{self.rows[row][col].inspect}".colorize(:background => color)
        end

      end
      print " #{row + 1}"
      puts ""
    end
    print "  "
    ('a'..'h').each { |letter| print "#{letter} " }
    puts ""

    print "Pieces Eaten: #{pieces_eaten}"
    puts ""
  end

  def colorz(color)
    color == :light_black ? :light_white : :light_black
  end

  def dup
    board_dup = Board.new(false)
    @rows.each do |row|
      row.each do |col|
        next if col.nil?
        board_dup[col.pos] = col.class.new(col.pos, board_dup, col.color)
      end
    end

    board_dup
  end

  def in_check?(color)
    my_king = color_pieces(color).find { |piece| piece.is_a?(King) }
    color_pieces(other_color(color)).any? { |piece| piece.moves.include?(my_king.pos) }
  end

  def other_color(color)
    color == :w ? :b : :w
  end

  def color_pieces(color)
    @rows.flatten.compact.select { |piece| piece.color == color }
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]

    if piece.move_into_check?(end_pos)
      raise MovingtoCheckError
    elsif !piece.moves.include?(end_pos)
       raise StupidMoveError
    else
      move!(start_pos, end_pos)
      if piece.is_a?(Pawn) && (piece.pos[1] == 0 || piece.pos[1] == 7)
        begin
          piece.transform
        rescue BadTransformError
          puts "Pick a valid piece (q, b, r, or k)"
          retry
        end
      end
    end
  end

  def move!(start_pos, end_pos)
    piece = self[start_pos]
    pieces_eaten << self[end_pos] unless self[end_pos].nil?
    
    self[end_pos] = piece
    piece.pos = end_pos
    self[start_pos] = nil

    piece
  end

  def checkmate?(color)
    in_check?(color) && no_valid_moves?(color)
  end

  def no_valid_moves?(color)
    color_pieces(color).all? { |piece| piece.valid_moves == [] }
  end
end
