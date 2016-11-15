require_relative '../../test_init'

context "Writer, Writes Module Message" do
  message = Controls::Message::ModuleMessage

  address = Messaging::Address.build

  write = Messaging::Write.new
  write.(message, address)

  test "Message name is written" do
    assert address.queue do
      deq == :module_message
    end
  end
end
