def initialize
  @string = String.new
end

def << event
  case event
  when String
    @string << event
  when Symbol
    case event
    when :backspace
      @string = @string[0..-2]
    end
  when Array
    case event
    when [:ctrl, ?u]
      @string.clear
    end
  end
end

def size
  @string.size
end

def to_s
  @string
end
