require_relative '../../test_init'

context "Queue Substitute, Empty Predicate" do
  context "No message has been enqueued" do
    substitute = Messaging::Queue::Substitute.new

    test "Substitute is empty" do
      assert substitute do
        empty?
      end
    end
  end

  context "Message has been enqueued" do
    substitute = Messaging::Queue::Substitute.new
    substitute.enq :some_message

    test "Substitute is not empty" do
      refute substitute do
        empty?
      end
    end
  end
end
