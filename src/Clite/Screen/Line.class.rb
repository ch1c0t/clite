def initialize
  @string = String.new
  @cursor = 0
end

def add string
  @string.insert @cursor, string
  @cursor += string.size
end

attr_reader :cursor

def to_s
  @string
end

def render size
  array = Array.new size.rows
  array[0] = to_s
  array
end

def clear
  @string.clear
  @cursor = 0
end

def move_cursor_left
  @cursor -= 1 unless @cursor == 0
end

def move_cursor_right
  @cursor += 1 unless @cursor >= @string.size
end

def backspace
  unless @cursor.zero?
    @cursor -= 1
    @string.slice! @cursor
  end
end

def delete_where_cursor
  @string.slice! @cursor
end

def delete_until_end
  @string = @string[0...@cursor]
end

def move_cursor_to_start
  @cursor = 0
end

def move_cursor_to_end
  @cursor = @string.size
end
