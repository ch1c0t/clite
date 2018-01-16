def initialize screen
  super

  self.layout = Layout.new

  add_pane :bar, Bar.new, 0...1
  add_pane :line, Line.new, 2...3
  add_pane :view, View.new, 4...-1

  self.active_pane = line

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
end

def react_to event
  super
  line.add event if event.is_a? String
end
