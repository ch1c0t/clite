def initialize
  queue = Queue.new

  push_current_time_to queue
  push_keyboard_events_to queue

  super do |y|
    loop { y << queue.pop }
  end
end

private
  def push_current_time_to queue
    Thread.new do
      loop do
        queue.push Time.now.to_s
        sleep 3
      end
    end
  end

  def push_keyboard_events_to queue
    keyboard = Keyboard.new

    Thread.new do
      loop { queue.push keyboard.next }
    end
  end
