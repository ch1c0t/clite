SEQUENCES = {
  "\r" => :enter,
  "\t" => :tab,
  "\u0003" => [:ctrl, ?c],
  "\u0015" => [:ctrl, ?u],
  "\u0001" => [:ctrl, ?a],
  "\u0005" => [:ctrl, ?e],
  "\u0011" => [:ctrl, ?q],
  "\v"     => [:ctrl, ?k],
  "\u007F" => :backspace,
}

def initialize
  super do |y|
    loop do
      key = STDIN.getch
      value = SEQUENCES[key] || key

      y << value
    end
  end
end
