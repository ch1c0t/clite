require 'io/console'

require 'clite/screen'

class Clite
  def initialize
    @screen = Screen.new
  end

  def run
    @screen.update

    loop do
      char = STDIN.getch
      @screen.update char
      break if char == ?q
    end
  end
end
