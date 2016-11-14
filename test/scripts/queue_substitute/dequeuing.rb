require_relative '../../test_init'

context "Queue Substitute, Dequeuing" do
  substitute = Messaging::Queue::Substitute.build

  context "Dequeuing messages (non-blocking is not specified)" do
    test "WouldBlockError is raised" do
      assert proc { substitute.deq } do
        raises_error? Messaging::Queue::Substitute::WouldBlockError
      end
    end
  end

  context "Reading messages (non-blocking is enabled)" do
    test "ThreadError is raised" do
      assert proc { substitute.deq true } do
        raises_error? ThreadError
      end
    end
  end
end
