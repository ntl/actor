require_relative '../init'

class Fizzbuzz
  include Actor

  def initialize stop_position
    @stop_position = stop_position

    @position = 0
  end

  # When the actor is running, this method will be executed in rapid succession
  # by an infinite loop.
  def action
    @position += 1

    output = String.new

    output << 'Fizz' if @position % 3 == 0
    output << 'Buzz' if @position % 5 == 0
    output << @position.to_s if output.empty?

    puts output

    if @position == @stop_position
      puts "Done!"
      # Raising StopIteration anywhere in this method will cause both the actor
      # (self) and the thread executing it to terminate.
      raise StopIteration 
    end
  end
end

_, thread = Fizzbuzz.start 1000, incude: %i(thread)

thread.join
