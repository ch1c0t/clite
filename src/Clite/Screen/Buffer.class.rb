def initialize size
  @rows = Array.new size do 'some string' end
end

def to_a
  @rows
end
