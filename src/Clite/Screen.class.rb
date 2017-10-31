def initialize
  rows_size, columns_size = STDIN.winsize
  @rows = Array.new(rows_size) { String.new }
  
  @rows[1] = '-' * columns_size
  @rows[3] = '-' * columns_size
end

def update event = ''
  case event
  when Time
    update_header_with event.to_s
  else
    update_line_with event.to_s
  end

  render_rows
end

private
  def update_header_with string
    line = @rows[0]
    line.clear
    line << string
  end

  def update_line_with string
    line = @rows[2]
    line.clear
    line << string
  end

  def render_rows
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
    print @rows.join "\r\n"
  end

  def escape code
    print "\e[#{code}"
  end
