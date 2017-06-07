module SlidingPiece
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
  def moves(position=nil)
    position ||= @position
    result = []
    i, j = position
    if move_dirs.include?(:sideways)
      (-7..7).each do |x|
        result << [i + x, j] if in_bounds?(i+x)
      end
      (-7..7).each do |y|
        result << [i, j+y] if in_bounds?(j+y)
      end
    end

    if move_dirs.include?(:diagonal)
      (-7..7).each do |z|
        result << [i+z, j+z] if in_bounds?(i+z) && in_bounds?(j+z)
        result << [i+z, j-z] if in_bounds?(i+z) && in_bounds?(j-z)
      end
    end

    result
  end
end

module SteppingPiece
  KING = {
    down: [0, -1],
    up: [0, 1],
    right: [1, 0],
    left: [-1, 0],
    NE: [1, 1],
    NW: [1, -1],
    SE: [-1, 1],
    SW: [-1, -1],
  }

  KNIGHT = {
    down: [2, -1],
    up: [2, 1],
    right: [1, 2],
    left: [-1, 2],
    NE: [-2, 1],
    NW: [-2, -1],
    SE: [1, -2],
    SW: [-1, -2],
  }
  def moves(position = nil)  # [2, 7]
    position ||= @position
    result = []
    i, j = position

    if move_dirs.include?(:one_space)
      KING.each do |k, v|
        x, y = v
        result << [x + i, y + j] # [2, 7] => [2, 6]
      end
    end
    if move_dirs.include?(:one_by_two)
      KNIGHT.each do |k, v|
        x, y = v
        result << [x + i, y + j] # [2, 7] => [2, 6]
      end
    end
    result
  end
end

module PawnPiece
  BLACK_PAWN = {
    up: [-1, 0],
    NW: [-1, 1],
    SW: [-1, -1],
    double: [-2, 0]
  }

  WHITE_PAWN = {
    down: [1, 0],
    NW: [1, 1],
    SW: [1, -1],
    double: [2, 0]
  }

  def moves(position = nil)  # [2, 7]
    position ||= @position
    result = []
    i, j = position

    if move_dirs.include?(:white)
      WHITE_PAWN.each do |k, v|
        x, y = v
        result << [x + i, y + j] # [2, 7] => [2, 6]
      end
    else
      BLACK_PAWN.each do |k, v|
        x, y = v
        result << [x + i, y + j] # [2, 7] => [2, 6]
      end
    end
    result
  end
end
