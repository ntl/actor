require_relative '../../test_init'

context "Queue Substitute, Dequeuing" do
  context "Read message is not supplied to substitute" do
    substitute = Messaging::Queue::Substitute.build

    context "Dequeuing messages (non-blocking is not specified)" do
      test "WouldBlockError is raised" do
        assert proc { substitute.deq } do
          raises_error? Messaging::Queue::Substitute::WouldBlockError
        end
      end
    end

    context "Reading messages (non-blocking is enabled)" do
      message = substitute.deq true

      test "Nothing is returned" do
        assert message.nil?
      end
    end
  end

  context "Read message is supplied to substitute" do
    substitute = Messaging::Queue::Substitute.build
    substitute.add :some_message

    context "Dequeue operation is performed" do
      message = substitute.deq

      test "Specified message is returned" do
        assert message == :some_message
      end

      test "Internal queue is drained" do
        assert substitute do
          empty?
        end
      end
    end
  end
end
