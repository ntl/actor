require_relative '../../test_init'

context "Writer, Writes Module Message" do
  message = Controls::Message::ModuleMessage

  address = Messaging::Address.build

  writer = Messaging::Writer.new
  writer.write message, address

  test "Message name is written" do
    assert address.queue do
      deq == :module_message
    end
  end
end
