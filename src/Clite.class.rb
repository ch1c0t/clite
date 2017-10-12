require 'io/console'

def initialize
  @screen = Screen.new
  @events = Events.new
end

def run
  @screen.update

  loop do
    event = @events.next
    @screen.update event
    break if event == ?q
  end
end
