def initialize
  rows_size, columns_size = STDIN.winsize
  @rows = Array.new(rows_size) { String.new }
  
  @buffer = Buffer.new 8
  update_buffer

  @rows[1] = '-' * columns_size
  @line = @rows[2] = @rows[4] = Line.new @buffer
  @rows[3] = '-' * columns_size
end

def update event = ''
  update_line_with event
  render_rows
end

private
  def update_line_with string
    @line << string
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
