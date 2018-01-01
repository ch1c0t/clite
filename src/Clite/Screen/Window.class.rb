def initialize
  @rows_count, @columns_count = STDIN.winsize
  @rows = Array.new @rows_count
  @panes = []
end

def borders= array_of_numbers
  @borders = array_of_numbers
  @places = find_places_with array_of_numbers
end

def add_pane place, name, element
  define_singleton_method(name) { element }

  if place > @borders.size
    fail "No place #{place} when there is only #{@borders.size} borders."
  else
    pane = Pane.new
    pane.name = name
    pane.range = @places[place]
    pane.element = element
    @panes << pane
  end
end

def render
  @panes.each do |pane|
    @rows[pane.range] = pane.render
  end

  @borders.each { |row| add_border_at row }

  @rows
end

private
  def add_border_at row
    @rows[row] = '-' * @columns_count
  end

  def find_places_with borders
    borders = borders.map { |number| number + 1 }
    borders = [0, *borders, @rows.size-1]
    borders.each_cons(2).map { |first, second| first...second }
  end
