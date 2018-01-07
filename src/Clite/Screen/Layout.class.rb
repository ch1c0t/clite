def render panes, size
  rows = Array.new size.rows

  rows[0...1] = panes[0].render size.excerpt(0...1)
  rows[2...3] = panes[1].render size.excerpt(2...3)
  rows[4...-1] = panes[2].render size.excerpt(4...-1)

  rows[1] = horizontal_border_of size.columns
  rows[3] = horizontal_border_of size.columns

  rows
end

private
  def horizontal_border_of size
    '-' * size
  end
