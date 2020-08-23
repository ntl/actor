require_relative '../../../test_init'

context "Queue Substitute, Dequeuing" do
  substitute = Messaging::Queue::Substitute.build

  context "Dequeuing messages (non-blocking is not specified)" do
    test "WouldBlockError is raised" do
      assert_raises Messaging::Queue::Substitute::WouldBlockError do
        substitute.deq
      end
    end
  end

  context "Reading messages (non-blocking is enabled)" do
    test "ThreadError is raised" do
      assert_raises ThreadError do
        substitute.deq true
      end
    end
  end
end
