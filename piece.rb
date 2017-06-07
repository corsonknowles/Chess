# Sliding pieces (Bishop/Rook/Queen)
# Stepping pieces (Knight/King)
# Null pieces (occupy the 'empty' spaces)
# Pawns (we'll do this class last)

require_relative 'piece_modules'
require 'singleton'
# require_relative 'SlidingPiece'
# require_relative 'SteppingPiece'

class Piece
  attr_accessor :position
  attr_reader :color

  def initialize(position = [0,0], symbol = "n", color="none")
    @symbol = symbol
    @position = position
    @color = color
  end

  def moves
    legal_moves = []
  end

  def to_s
    @symbol
  end

  def valid_moves
    #exclude running into pieces
    result.select! do |possible_pos|
    end
  end

  def in_bounds?(position)
    (0..7).cover?(position)
  end


  def past_board?

  end

  def hits_piece?

  end

  def choose_direction

  end

end

class NullPiece < Piece
  attr_reader :color, :symbol
  include Singleton
  def initialize
    @color = "none"
    @symbol = "n"
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(position, _, color)
    super(position, "B", color)
  end

  def move_dirs
    [:diagonal]
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(position, _, color)
    super(position, "R", color)
  end

  def move_dirs
    [:sideways]
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(position, _, color)
    super(position, "Q", color)
  end

  def move_dirs
    [:diagonal, :sideways]
  end
end


class King < Piece
  include SteppingPiece

  def initialize(position, _, color)
    super(position, "K", color)
  end

  def move_dirs
    [:one_space]

  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(position, _, color)
    super(position, "N", color)
  end

  def move_dirs
    [:one_by_two]
  end
end


#fix this
class Pawns < Piece
  include PawnPiece

  def initialize(position, _, color)
    super(position, "W", color)
  end

  def move_dirs
    [color]

  end

end



# DIFF.each do |k, v|
#   next if [:NE, :NW, :SE, :SW].include?(k)
#   x, y = v
#   i, j = position
#   result[k] = [x+i, y+j]  # [2, 7] => [2, 6]
# end
