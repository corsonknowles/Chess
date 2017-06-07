require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'


class Display
  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    @board.grid.each_with_index do |line, i|
      line = line.map.with_index do |entry, j|
        if @cursor.cursor_pos == [i,j]
          if @cursor.selected
            "P".colorize(:red)
          else
            "Y".colorize(:green)
          end
          # if @cursor.selected && !@board.grid[i, j].is_a?(NullPiece)
          #
          # end
        elsif @board.grid[i][j].is_a?(Piece)
            @board.grid[i][j].to_s.colorize(:yellow)
        else
          "X".colorize(:blue)
        end
      end
      puts line.join
    end
  end
end

def pick_up_piece
  if @cursor.selected
    move_piece(@cursor.selected, end_pos)

  end
end

def put_down_piece

end


def [](pos)
  x, y = pos
  self[x, y]
end

def []=(position, val)
  x, y = position
  self[x, y] = val
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  # rook = Rook.new([0,0])
  # board.add_piece(rook, [0,0])
  # board.add_piece(Queen.new([1,1]), [1,1])
  # board.add_piece(King.new([3,3]), [3,3])
  # board.add_piece(Knight.new([4,4]), [4,4])
  #
  # board.add_piece(Bishop.new([2,2]), [2,2])

  display = Display.new(board)
  display.render
  puts board.grid[0][0]
  i = 0
  while true
    display.cursor.get_input
    system("clear")
    display.render
    i += 1
  end
end
