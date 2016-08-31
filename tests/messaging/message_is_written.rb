require_relative '../test_init'

context "Writing a message" do
  address = Messaging::Address.build
  writer = Messaging::Writer.build address

  context "Address has no readers" do
    writer.write 'some-message'

    test "Message is not written to address queue" do
      assert address.queue, &:empty?
    end
  end

  context "Address has a reader" do
    Messaging::Reader.build address

    writer.write 'some-message'

    test "Message is written to address queue" do
      assert address.queue do
        contains? 'some-message'
      end
    end
  end
end
