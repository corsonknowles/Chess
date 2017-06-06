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
        else
          "X".colorize(:blue)
        end
      end
      puts line.join
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render

  i = 0
  while true
    display.cursor.get_input
    system("clear")
    display.render
    i += 1
  end
end
