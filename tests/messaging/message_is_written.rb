require_relative '../test_init'

context "Writing a message" do
  address = Messaging::Address.get
  writer = Messaging::Writer.build address

  context "Address has no consumers" do
    writer.write 'some-message'

    test "Message is not written to address queue" do
      assert address.queue, &:empty?
    end
  end

  context "Address has a consumer" do
    consumer = Messaging::Consumer.build address

    writer.write 'some-message'

    test "Message is written to address queue" do
      assert address.queue do
        contains? 'some-message'
      end
    end
  end
end
