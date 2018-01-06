def initialize
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

def add_pane range, name, element
  define_singleton_method(name) { element }

  pane = Pane.new
  pane.name = name
  pane.range = range
  pane.element = element
  @panes << pane
end

def render size
  layout.render @panes, size
end
