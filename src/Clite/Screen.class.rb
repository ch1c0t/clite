require 'open3'

def initialize window = Window::DEFAULT.new
  @window = window
  update
end

attr_reader :window

def update event = ''
  window.react_to event
  render_rows
end

private
  def render_rows
    clear
    print_rows
    position_cursor
  end

  def escape code
    print "\e[#{code}"
  end

  def clear
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
  end

  def print_rows
    print window.render.map(&:to_s).join "\r\n"
  end

  def position_cursor
    row, column = window.cursor
    escape "#{row};#{column}H"
  end
