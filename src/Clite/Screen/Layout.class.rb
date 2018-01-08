def initialize
  @panes = {}
end

def render size
  rows = Array.new size.rows

  @panes.each do |range, pane|
    rows[range] = pane.render size.excerpt(range)
  end

  @panes.keys[0..-2].map(&:last).each do |row|
    rows[row] = horizontal_border_of size.columns
  end

  rows
end

def []= range, pane
  @panes[range] = pane
end

private
  def horizontal_border_of size
    '-' * size
  end
