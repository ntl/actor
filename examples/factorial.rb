require_relative '../init'

class Factorial
  include Actor

  attr_reader :number, :reply_address

  def initialize number, reply_address
    @number, @reply_address = number, reply_address
  end

  handle :start do
    if number == 1
      result = 1
    else
      previous_factorial = Actor::Future.build do |address|
        Factorial.start number - 1, address
      end

      result = previous_factorial.get(wait: true) * number
    end

    writer.(result, reply_address)

    :stop
  end
end

result = Actor::Future.get wait: true do |address|
  Factorial.start 42, address
end

puts "fac(42) = #{result}"
