def initialize
  super

  self.borders = [1, 3]
  
  add_pane 0, :bar, Bar.new
  add_pane 1, :line, Line.new
  add_pane 2, :view, View.new
end
