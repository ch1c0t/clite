def initialize
  @events = {
    [:ctrl, ?u] => -> { line.clear },
    [:ctrl, ?a] => -> { line.move_cursor_to_start },
    [:ctrl, ?e] => -> { line.move_cursor_to_end },
    [:ctrl, ?k] => -> { line.delete_until_end },

    :left_arrow => -> { line.move_cursor_left },
    :right_arrow => -> { line.move_cursor_right },

    :delete => -> { line.delete_where_cursor },
    :backspace => -> { line.backspace },
  }

  rows_size, columns_size = STDIN.winsize
  @rows = Array.new(rows_size) { String.new }
  
  @buffer = Buffer.new 8
  update_buffer

  @rows[1] = '-' * columns_size
  @line = @rows[2] = @rows[4] = Line.new @buffer
  @rows[3] = '-' * columns_size
end

attr_reader :line

def update event = ''
  react_to event
  render_rows
end

private
  def react_to event
    if screen_event = @events[event]
      instance_exec &screen_event
    end
    @line << event
  end

  def render_rows
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
    update_buffer
    print @rows.map(&:to_s).join "\r\n"
    escape "3;#{@line.cursor+1}H"
  end

  def update_buffer
    @rows[6..13] = @buffer.to_a
  end

  def escape code
    print "\e[#{code}"
  end
