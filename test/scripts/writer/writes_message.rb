require_relative '../../test_init'

context "Writer, Writes Message" do
  address = Messaging::Address.build

  write = Messaging::Write.new
  write.(:some_message, address)

  test "Message is written to queue of specified address" do
    assert address.queue do
      size == 1 and deq == :some_message
    end
  end
end
