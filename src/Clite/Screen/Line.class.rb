def initialize
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
    when :backspace
      unless @cursor.zero?
        @string.slice! (@cursor-1)
        @cursor -= 1
      end
    end
  when Array
    case event
    when [:ctrl, ?u]
      @string.clear
      @cursor = 0
    when [:ctrl, ?a]
      @cursor = 0
    when [:ctrl, ?e]
      @cursor = @string.size
    end
  end
end

attr_reader :cursor

def to_s
  @string
end
