require 'open3'

def initialize window = Window::DEFAULT.new
  @events = {
    [:ctrl, ?q] => -> { exit },
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

      bar.increment
      line.clear

      view.add stdout
    }
  }

  @window = window
  update
end

attr_reader :window

def update event = ''
  react_to event
  render_rows
end

private
  def react_to event
    if action = @events[event]
      window.instance_exec &action
    else
      window.line.add event.to_s
    end
  end

  def render_rows
    clear
    update_rows
    print_rows
    position_cursor
  end

  def update_rows
    @rows = window.render
  end

  def escape code
    print "\e[#{code}"
  end

  def clear
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
  end

  def print_rows
    print @rows.map(&:to_s).join "\r\n"
  end

  def position_cursor
    row, column = window.cursor
    escape "#{row};#{column}H"
  end
