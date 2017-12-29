require 'open3'

def initialize
  @events = {
    [:ctrl, ?q] => ->{},
    [:ctrl, ?u] => -> { line.clear },
    [:ctrl, ?a] => -> { line.move_cursor_to_start },
    [:ctrl, ?e] => -> { line.move_cursor_to_end },
    [:ctrl, ?k] => -> { line.delete_until_end },

    :left_arrow => -> { line.move_cursor_left },
    :right_arrow => -> { line.move_cursor_right },

    :delete => -> { line.delete_where_cursor },
    :backspace => -> { line.backspace },
    :enter => -> {
      stdout, _stderr, _status = Open3.capture3 line.to_s
      line.clear

      buffer.add stdout
    }
  }

  initialize_borders
  initialize_components
  update
end

attr_reader :line, :buffer

def update event = ''
  react_to event
  render_rows
end

private
  def react_to event
    if screen_event = @events[event]
      instance_exec &screen_event
    else
      line.add event.to_s
    end
  end

  def render_rows
    clear
    update_buffer
    print_rows
    escape "3;#{@line.cursor+1}H"
  end

  def update_buffer
    @rows[4..-1] = @buffer.to_a
  end

  def escape code
    print "\e[#{code}"
  end

  def initialize_borders
    rows_size, columns_size = STDIN.winsize
    @rows = Array.new rows_size
    @rows[1] = '-' * columns_size
    @rows[3] = '-' * columns_size
  end

  def initialize_components
    @buffer = Buffer.new
    @line = @rows[2] = Line.new
  end

  def clear
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
  end

  def print_rows
    print @rows.map(&:to_s).join "\r\n"
  end
