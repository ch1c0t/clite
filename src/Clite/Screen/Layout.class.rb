def initialize
  @panes = {}
end

def render size
  rows = Array.new size.rows

  @panes.each do |range, pane|
    rows[range] = pane.render size.excerpt(range)
  end

  rows[1] = horizontal_border_of size.columns
  rows[3] = horizontal_border_of size.columns

  rows
end

def []= range, pane
  @panes[range] = pane
end

private
  def horizontal_border_of size
    '-' * size
  end
