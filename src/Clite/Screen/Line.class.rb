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
  end
end

def to_s
  @string
end
