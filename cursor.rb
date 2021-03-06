require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    # @picked_up_a_piece = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def [](pos)
    x, y = pos
    self[x, y]
  end

  def []=(position, val)
    x, y = position
    self[x, y] = val
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :return, :space
      if @selected
        possible_move = @cursor_pos
        selected_piece = @board[@selected]
        if selected_piece.moves.include?(possible_move)
          @board.move_piece(@selected, @cursor_pos)
        end
      end
      toggle_selected(@cursor_pos)
      @cursor_pos
    when :left
      update_pos(MOVES[:left])
    when :right
      update_pos(MOVES[:right])
    when :up
      update_pos(MOVES[:up])
    when :down
      update_pos(MOVES[:down])
    when :ctrl_c
      Process.exit(0)
  # else

    end
  end

  def update_pos(diff)
    x, y = diff
    if Board.in_bounds?([@cursor_pos.first + x, @cursor_pos.last + y])
      @cursor_pos = [@cursor_pos.first + x, @cursor_pos.last + y]
    end

    # when condition
    #
    # end
  end

  def to_s
    "X"
  end

  def toggle_selected(position = nil)
    if @selected
      @selected = false
    else
      @selected = position
    end
    # puts @selected
    # @pick_up_piece =
    # @selected = !@selected
    #return a position or store or mark a position
  end

end
