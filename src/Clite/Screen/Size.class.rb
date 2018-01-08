def initialize pair
  @rows, @columns = pair
end

def excerpt range
  rows = if range.last == -1
    (range.first...(@rows-1)).size
  else
    range.size
  end

  self.class.new [rows, columns]
end

attr_reader :rows, :columns

def of_rows
  @rows
end

def of_columns
  @columns
end
