def initialize size
  @rows = Array.new size do 'some string' end
end

def add string
  @rows[0] = string.dup
end

def to_a
  @rows
end
