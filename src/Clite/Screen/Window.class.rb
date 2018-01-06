def initialize
  @rows_count, @columns_count = STDIN.winsize
  @rows = Array.new @rows_count
  @panes = []
end

attr_accessor :layout

def react_to event
  if action = @events[event]
    instance_exec &action
  end
end

def cursor
  [3, line.cursor+1]
end

def borders= array_of_numbers
  @borders = array_of_numbers
  @places = find_places_with array_of_numbers
end

def add_pane range, name, element
  define_singleton_method(name) { element }

  pane = Pane.new
  pane.name = name
  pane.range = range
  pane.element = element
  @panes << pane
end

require 'logger'
L = Logger.new '/tmp/clite.log'

def render size
  layout.render @panes, size
end

private
  def add_border_at row
    @rows[row] = '-' * @columns_count
  end

  def find_places_with borders
    beginnings = [ 0, *borders.map { |n| n+1 } ]
    endings = [ *borders, (@rows.size-1) ]
    beginnings.zip(endings).map { |b, e| b...e }
  end
