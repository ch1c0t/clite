def initialize
  @rows = []
end

def add string
  @rows = string.split "\n"
end

def to_a number_of_rows
  @rows.take number_of_rows
end
