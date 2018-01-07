def initialize
  @count = 0
end

def increment
  @count += 1
end

def to_s
  @count.to_s
end

def render size
  array = Array.new size.rows
  array[0] = to_s
  array
end
