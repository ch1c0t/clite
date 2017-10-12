require 'io/console'

def initialize
  @screen = Screen.new
  @keyboard = Keyboard.new
end

def run
  @screen.update

  loop do
    event = @keyboard.next
    @screen.update event
    break if event == ?q
  end
end
