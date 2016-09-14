require_relative '../test_init'

context "Get operation of a future when message has not yet arrived" do
  reader = Messaging::Read::Substitute.new

  future = Future.new reader

  context "Wait is not specfied" do
    message_read = future.get

    test "Nothing is returned" do
      assert message_read == nil
    end
  end

  context "Wait is specified" do
    test "Thread is blocked" do
      assert proc { future.get wait: true } do
        raises_error? Messaging::Read::Substitute::WouldWait
      end
    end
  end
end
