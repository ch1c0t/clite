def initialize
  @rows = []
end

def add string
  @rows = string.split "\n"
end

def to_a
  @rows
end

def render size
  @rows.take size.rows
end
