attr_accessor :name, :range, :element

def render
  element.render range.size
end
