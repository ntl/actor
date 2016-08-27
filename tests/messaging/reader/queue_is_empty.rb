require_relative '../../test_init'

context "Reading an address whose queue is empty" do
  address = Messaging::Address.get
  reader = Messaging::Reader.build address

  context "Wait is not requested (default)" do
    test "Nothing is returned" do
      assert reader.next == nil
    end
  end

  context "Wait is requested" do
    message = nil

    thread = Thread.new do
      message = reader.next wait: true
    end
    Thread.pass until thread.stop?

    address.queue.write 'some-message'

    thread.join

    test "Message is returned" do
      assert message == 'some-message'
    end
  end
end
