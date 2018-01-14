def initialize screen
  @screen = screen
end

attr_accessor :screen, :layout

def react_to event
  if action = @events[event]
    instance_exec &action
  end
end

def cursor
  [3, line.cursor+1]
end

def add_pane name, pane, range
  define_singleton_method(name) { pane }
  layout[range] = pane
end

def render size
  layout.render size
end
