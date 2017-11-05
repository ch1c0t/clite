def initialize
  rows_size, columns_size = STDIN.winsize
  @rows = Array.new(rows_size) { String.new }
  
  @rows[1] = '-' * columns_size
  @rows[2] = @rows[4] = Line.new
  @rows[3] = '-' * columns_size
end

def update event = ''
  case event
  when Time
    update_header_with event.to_s
  else
    update_line_with event
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
    line << string
  end

  def render_rows
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
    print @rows.map(&:to_s).join "\r\n"
    escape "3;#{@rows[2].size+1}H"
  end

  def escape code
    print "\e[#{code}"
  end
