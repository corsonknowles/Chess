require_relative 'piece'

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
    grid ||= Array.new(7) { Array.new(7) }
    @grid = grid
  end

  def move_piece(start_pos, end_pos)

  end

  def self.in_bounds?(position)
    x, y = position
    (0..7).cover?(x) && y.between?(0, 7)
  end

end
