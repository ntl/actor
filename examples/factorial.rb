require_relative '../init'

class Factorial
  include Actor

  attr_reader :number, :reply_address

  def initialize number, reply_address
    @number, @reply_address = number, reply_address
  end

  handle :start do
    if number == 1
      reply 1
    else
      Factorial.start number - 1, address
    end
  end

  handle :result do |previous_result|
    value = previous_result.value * number

    reply value
  end

  def reply value
    result = Result.new value, number

    write.(result, reply_address)

    :stop
  end

  Result = Struct.new :value, :number do
    include Actor::Messaging::Message
  end
end

result_address = Actor::Messaging::Address.build

Factorial.start 42, result_address

result = Actor::Messaging::Read.(result_address)

puts "fac(42) = #{result.value}"
