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

  "\e" => {
    ?w => [:alt, ?w],
    ?[ => {
      ?D => :left_arrow,
      ?C => :right_arrow,
      ?3 => {
        ?~ => :delete,
      },
    },
  },
}

def initialize
  super do |y|
    hash = SEQUENCES

    loop do
      key = STDIN.getch
      value = hash[key]

      case value
      when Hash
        hash = value
      else
        value ? y << value : y << key
        hash = SEQUENCES
      end
    end
  end
end
