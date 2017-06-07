require 'byebug'
require_relative 'piece'
require_relative 'cursor' #remove when move pick_up_piece to game class

# Phase I: Board
#
# Your Board class should hold a 2-dimensional array (an array of arrays). Each position in the board either holds a moving Piece or a NullPiece (NullPiece will inherit from Piece).
#
# You'll want to create an empty Piece class as a placeholder for now. Write code for #initialize so we can setup the board with instances of Piece in locations where a Queen/Rook/Knight/ etc. will start and nil where the NullPiece will start.
#
# The Board class should have a #move_piece(start_pos, end_pos) method. This should update the 2D grid and also the moved piece's position. You'll want to raise an exception if:
#
# there is no piece at start_pos or
# the piece cannot move to end_pos.
# Time to test! Open up pry and load 'board.rb'. Create an instance of Board and check out different positions with board[pos]. Do you get back Piece instances where you expect to? Test out Board#move_piece(start_pos, end_pos), does it raise an error when there is no piece at the start? Does it successfully update the Board?

class Board
  attr_accessor :position
  attr_reader :grid

  def initialize(grid=nil)
    grid ||= Array.new(8) { Array.new(8) }
    @grid = grid
    start_pieces
  end

  def start_pieces
    back_row = ["rook", "bishop", "knight", "queen", "king", "knight", "bishop", "rook"]
    null = NullPiece.instance

    @grid.map!.with_index do |line, index1|
      if (0..1).cover?(index1)
        color = :white
      else
        color = :black
      end
      line.map!.with_index do |entry, index2|
        if index1 == 0 || index1 == 7
          piece_title = back_row[index2]
          _ = nil
          case piece_title
          when "rook"
            Rook.new([index1, index2], _, color)
          when "bishop"
            Bishop.new([index1, index2], _, color)
          when "knight"
            Knight.new([index1, index2], _, color)
          when "queen"
            Queen.new([index1, index2], _, color)
          when "king"
            King.new([index1, index2], _, color)
          end

        elsif index1 == 1 || index1 == 6
          Pawns.new([index1, index2], _, color)
        else
          null
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    # debugger
    null = NullPiece.instance
    piece = self[start_pos]
    piece.position = end_pos
    self[end_pos] = piece
    self[start_pos] = null
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(position, val)
    x, y = position
    @grid[x][y] = val
  end

  def self.in_bounds?(position)
    x, y = position
    (0..7).cover?(x) && y.between?(0, 7)
  end

  def add_piece(piece, position = nil)
    position ||= [0,0]
    x, y = position
    @grid[x][y] = piece
  end

end
