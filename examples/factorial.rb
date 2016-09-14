require_relative '../init'

class Factorial
  include Actor

  def initialize number, reply_address
    @number, @reply_address = number, reply_address
  end

  handle :start do
    if @number == 1
      value = 1
    else
      prev_number = @number - 1
      prev_result_reply_address = Actor::Address.build

      Factorial.start prev_number, prev_result_reply_address

      prev_result = Messaging::Read.(prev_result_reply_address, wait: true)

      value = prev_result.value * @number
    end

    result = Result.new value

    writer.(result, @reply_address)

    :stop
  end

  Result = Struct.new :value do
    include Actor::Messaging::Message
  end
end

reply_address = Actor::Address.build

Factorial.start 42, reply_address

result = Actor::Messaging::Read.(reply_address, wait: true)

puts "fac(42) = #{result.value}"
