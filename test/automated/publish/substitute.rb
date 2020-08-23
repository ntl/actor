require_relative '../../test_init'

context "Publisher Substitute" do
  queue = Controls::Queue.example

  context "Queue registration" do
    substitute = Messaging::Publish::Substitute.new

    context "No queue has been registered" do
      test "Registered predicate without argument returns false" do
        refute substitute.registered?
      end
    end

    substitute.register queue

    test "Registered predicate without argument returns true" do
      assert substitute.registered?
    end

    test "Registered predicate returns true if argument matches queue" do
      assert substitute.registered?(queue)
    end

    test "Registered predicate returns false if argument does not match queue" do
      other_queue = Controls::Queue::Other.example

      refute substitute.registered?(other_queue)
    end
  end

  context "Queue unregistration" do
    substitute = Messaging::Publish::Substitute.new

    context "No queue has been registered" do
      test "Unregistered predicate without argument returns false" do
        refute substitute.unregistered?
      end
    end

    substitute.unregister queue

    test "Unregistered predicate without argument returns true" do
      assert substitute.unregistered?
    end

    test "Unregistered predicate returns true if argument matches queue" do
      assert substitute.unregistered?(queue)
    end

    test "Registered predicate returns false if argument does not match queue" do
      other_queue = Controls::Queue::Other.example

      refute substitute.unregistered?(other_queue)
    end
  end
  
  context "Publishing messages" do
    context "No message has been published" do
      substitute = Messaging::Publish::Substitute.new

      test "Published predicate without argument returns false" do
        refute substitute.published?
      end
    end

    context "Message has been published" do
      context do
        substitute = Messaging::Publish::Substitute.new

        substitute.(:some_message)

        test "Published predicate without argument returns true" do
          assert substitute.published?
        end

        test "Published predicate returns true if argument matches published message" do
          assert substitute.published?(:some_message)
        end

        test "Published predicate returns false if argument does not match published message" do
          refute substitute.published?(:other_message)
        end
      end

      [["Wait was not specified at callsite", nil], ["Wait was disabled at callsite", false]].each do |prose, wait|
        context prose do
          substitute = Messaging::Publish::Substitute.new

          substitute.(:some_message, wait: wait)

          test "Published predicate returns true if wait value is false" do
            assert substitute.published?(:some_message, wait: false)
          end

          test "Published predicate returns false if wait value is true" do
            refute substitute.published?(:some_message, wait: true)
          end
        end
      end

      context "Wait was enabled at callsite" do
        substitute = Messaging::Publish::Substitute.new

        substitute.(:some_message, wait: true)

        test "Published predicate returns true if wait value is true" do
          assert substitute.published?(:some_message, wait: true)
        end

        test "Published predicate returns false if wait value is false" do
          refute substitute.published?(:some_message, wait: false)
        end
      end
    end
  end
end
