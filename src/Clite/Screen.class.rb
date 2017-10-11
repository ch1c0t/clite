def initialize
  rows_size, columns_size = STDIN.winsize
  @rows = Array.new(rows_size) { String.new capacity: columns_size }
  
  @rows[1] = '-' * columns_size
  @rows[3] = '-' * columns_size
end

def update state = ''
  char = state
  update_line_with char
  render_rows
end

private
  def update_line_with char
    line = @rows[2]
    line.clear
    line << char
  end

  def render_rows
    escape '2J'   # clear screen
    escape '1;1H' # move to the top left corner
    print @rows.join "\r\n"
  end

  def escape code
    print "\e[#{code}"
  end
