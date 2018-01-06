def render panes, size
  rows = Array.new size.rows

  rows[0...1] = panes[0].render
  rows[2...3] = panes[1].render
  rows[4...-1] = panes[2].render

  rows[1] = horizontal_border_of size.columns
  rows[3] = horizontal_border_of size.columns

  rows
end

private
  def horizontal_border_of size
    '-' * size
  end
