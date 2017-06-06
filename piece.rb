# Sliding pieces (Bishop/Rook/Queen)
# Stepping pieces (Knight/King)
# Null pieces (occupy the 'empty' spaces)
# Pawns (we'll do this class last)


require 'singleton'
# require_relative 'SlidingPiece'
# require_relative 'SteppingPiece'

class Piece
  def initialize(type)
    @type = type
    @symbol = "K"
  end

  def moves
    legal_moves = []
  end
end

class NullPiece < Piece
  attr_reader :color, :symbol
  include Singleton
  def initialize
    @color = "none"
    @symbol = "none"
  end
end


module SlidingPiece
  DIFF = {

  }
  def moves
  end

  def move_dirs

  end
end

module SteppingPiece
  DIFF = {
    down: [0, -1],
    up: [0, 1],
    right: [1, 0],
    left: [-1, 0],
    NE: [1, 1],
    NW: [1, -1],
    SE: [-1, 1],
    SW: [-1, -1],
  }
  def moves(position)  # [2, 7]
    result = {}
    DIFF.each do |k, v|
      x, y = v
      i, j = position
      result[k] = [x+i, y+j]  # [2, 7] => [2, 6] 
    end
    result
  end

  def move_dirs

  end
end

class Bishop < Piece
  include SlidingPiece
end

class Rook < Piece
  include SlidingPiece
end

class Queen < Piece
  include SlidingPiece
end

class King < Piece
  include SteppingPiece
end

class Knight < Piece
  include SteppingPiece
end

class Pawns < Piece

end
