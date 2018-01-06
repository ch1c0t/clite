def initialize
  super

  self.borders = [1, 3]
  
  add_pane 0...1, :bar, Bar.new
  add_pane 2...3, :line, Line.new
  add_pane 4...-1, :view, View.new

  @events = {
    [:ctrl, ?q] => -> { exit },
    [:ctrl, ?u] => -> { line.clear },
    [:ctrl, ?a] => -> { line.move_cursor_to_start },
    [:ctrl, ?e] => -> { line.move_cursor_to_end },
    [:ctrl, ?k] => -> { line.delete_until_end },

    :left_arrow => -> { line.move_cursor_left },
    :right_arrow => -> { line.move_cursor_right },

    :delete => -> { line.delete_where_cursor },
    :backspace => -> { line.backspace },
    :enter => -> {
      stdout, _stderr, _status = Open3.capture3 line.to_s

      bar.increment
      line.clear

      view.add stdout
    },
  }

  self.layout = Layout.new
end

def react_to event
  super
  line.add event if event.is_a? String
end
