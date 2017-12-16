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
    when :delete
      @string.slice! @cursor
    end
  when Array
    case event
    when [:ctrl, ?a]
      @cursor = 0
    when [:ctrl, ?e]
      @cursor = @string.size
    when [:ctrl, ?k]
      @string = @string[0...@cursor]
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

