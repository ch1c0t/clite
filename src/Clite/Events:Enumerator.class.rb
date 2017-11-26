def initialize
  queue = Queue.new

  push_keyboard_events_to queue

  super do |y|
    loop { y << queue.pop }
  end
end

private
  def push_keyboard_events_to queue
    keyboard = Keyboard.new

    Thread.new do
      loop { queue.push keyboard.next }
    end
  end
