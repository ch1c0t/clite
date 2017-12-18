def initialize buffer
  @buffer = buffer
  @string = String.new
  @cursor = 0
end

def << event
  case event
  when String
    @string.insert @cursor, event
    @cursor += event.size
  when Symbol
    case event
    when :enter
      @buffer.add @string
      clear
    when :backspace
      unless @cursor.zero?
        @cursor -= 1
        @string.slice! @cursor
      end
    end
  end
end

attr_reader :cursor

def to_s
  @string
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
