require 'io/console'

class Clite
  def run
    loop do
      char = STDIN.getch
      puts "You typed #{char}."
      break if char == ?q
    end
  end
end
