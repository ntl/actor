require_relative '../../../test_init'

context "Queue Substitute, Enqueuing" do
  context "Enqueued predicate" do
    context "No message has been enqueued" do
      substitute = Messaging::Queue::Substitute.new

      test "Predicate returns false even if no constraints are specified" do
        refute substitute.enqueued?
      end
    end

    context "Message has been enqueued" do
      context "Message constraint" do
        substitute = Messaging::Queue::Substitute.new
        substitute.enq :some_message

        test "Predicate returns true if specified message matches enqueued message" do
          assert substitute.enqueued?(:some_message)
        end

        test "Predicate returns fals if specified message does not match enqueued message" do
          refute substitute.enqueued?(:other_message)
        end
      end

      context "Wait constraint" do
        context "Enqueue operation was allowed to block" do
          substitute = Messaging::Queue::Substitute.new
          substitute.enq :some_message

          test "Predicate returns true if specified wait value is true" do
            assert substitute.enqueued?(wait: true)
          end

          test "Predicate returns false if specified wait value is false" do
            refute substitute.enqueued?(wait: false)
          end
        end

        context "Enqueue operation was not allowed to block" do
          substitute = Messaging::Queue::Substitute.new
          substitute.enq :some_message, true

          test "Predicate returns true if specified wait value is false" do
            assert substitute.enqueued?(wait: false)
          end

          test "Predicate returns false if specified wait value is true" do
            refute substitute.enqueued?(wait: true)
          end
        end
      end
    end
  end
end
