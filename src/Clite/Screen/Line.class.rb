def initialize
  @string = String.new
  @cursor = 0
end

def << event
  case event
  when String
    @string << event
    @cursor += event.size
  when Symbol
    case event
    when :backspace
      @string = @string[0..-2]
      @cursor -= 1 unless @cursor.zero?
    end
  when Array
    case event
    when [:ctrl, ?u]
      @string.clear
      @cursor = 0
    end
  end
end

attr_reader :cursor

def to_s
  @string
end
