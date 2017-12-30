SEQUENCES = {
  "\r" => :enter,
  "\t" => :tab,
  "\u0003" => [:ctrl, ?c],
  "\u0015" => [:ctrl, ?u],
  "\u0001" => [:ctrl, ?a],
  "\u0005" => [:ctrl, ?e],
  "\u0011" => [:ctrl, ?q],
  "\n"     => [:ctrl, ?j],
  "\v"     => [:ctrl, ?k],
  "\u007F" => :backspace,
}

def initialize
  super do |y|
    loop do
      key = STDIN.getch

      if key == "\e"
        left_square_bracket = STDIN.getch
        fail unless left_square_bracket == ?[

        value = case STDIN.getch
        when ?D
          :left_arrow
        when ?C
          :right_arrow
        when ?3
          tilde = STDIN.getch
          fail unless tilde == ?~
          :delete
        end
      else
        value = SEQUENCES[key] || key
      end

      y << value
    end
  end
end
