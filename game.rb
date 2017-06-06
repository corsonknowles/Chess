require_relative 'display'
require_relative 'cursor'
require_relative 'board'

class Game
  def initialize(board, display)
    @board = board
    @display = display
  end

  def play
    i = 0
    until i > 5
      @cursor.get_input
      @display.render
      i += 1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
  game = Game.new(board, display)
end
