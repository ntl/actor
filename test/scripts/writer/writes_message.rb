require_relative '../scripts_init'

context "Writer, Writes Message" do
  address = Messaging::Address.build

  writer = Messaging::Writer.new
  writer.write :some_message, address

  test "Message is written to queue of specified address" do
    assert address.queue do
      size == 1 and deq == :some_message
    end
  end
end
