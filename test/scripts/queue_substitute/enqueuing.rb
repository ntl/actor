require_relative '../../test_init'

context "Queue Substitute, Enqueuing" do
  context "Enqueued predicate" do
    context "No message has been enqueued" do
      substitute = Messaging::Queue::Substitute.new

      test "Predicate returns false even if no constraints are specified" do
        refute substitute do
          enqueued?
        end
      end
    end

    context "Message has been enqueued" do
      context "Message constraint" do
        substitute = Messaging::Queue::Substitute.new
        substitute.enq :some_message

        test "Predicate returns true if specified message matches enqueued message" do
          assert substitute do
            enqueued? :some_message
          end
        end

        test "Predicate returns fals if specified message does not match enqueued message" do
          refute substitute do
            enqueued? :other_message
          end
        end
      end

      context "Wait constraint" do
        context "Enqueue operation was allowed to block" do
          substitute = Messaging::Queue::Substitute.new
          substitute.enq :some_message

          test "Predicate returns true if specified wait value is true" do
            assert substitute do
              enqueued? wait: true
            end
          end

          test "Predicate returns false if specified wait value is false" do
            refute substitute do
              enqueued? wait: false
            end
          end
        end

        context "Enqueue operation was not allowed to block" do
          substitute = Messaging::Queue::Substitute.new
          substitute.enq :some_message, true

          test "Predicate returns true if specified wait value is false" do
            assert substitute do
              enqueued? wait: false
            end
          end

          test "Predicate returns false if specified wait value is true" do
            refute substitute do
              enqueued? wait: true
            end
          end
        end
      end
    end
  end
end
