def initialize &block
  @panes = []
  instance_exec &block if block_given?
end

def pane_at range
  @panes << Pane.new(range)
end

def render size
  rows = Array.new size.rows

  @panes.each do |pane|
    range = pane.range
    rows[range] = pane.element.render size.excerpt(range)
  end

  @panes[0..-2].map(&:range).map(&:last).each do |row|
    rows[row] = horizontal_border_of size.columns
  end

  rows
end

def []= index, element
  @panes[index].element = element
end

private
  def horizontal_border_of size
    '-' * size
  end

class Pane
  def initialize range
    @range = range
  end

  attr_accessor :range, :element
end
