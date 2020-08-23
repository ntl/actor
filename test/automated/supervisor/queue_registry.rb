require_relative '../../test_init'

context "Get Queue of Supervisor" do
  context "No supervisor queue is registered" do
    Supervisor::Queue::Put.(nil)

    queue = Supervisor::Queue::Get.()

    test "Null queue is returned" do
      assert queue.is_a?(Messaging::Queue::Null)
    end
  end

  context "Supervisor queue is registered" do
    registered_queue = Controls::Queue.example

    Supervisor::Queue::Put.(registered_queue)

    context "Get Queue" do
      queue = Supervisor::Queue::Get.()

      test "Supervisor queue is returned" do
        assert queue == registered_queue
      end
    end
  end

  context "Supervisor queue is unregistered" do
    Supervisor::Queue::Put.(nil)

    context "Get Queue" do
      queue = Supervisor::Queue::Get.()

      test "Null queue is returned" do
        assert queue.is_a?(Messaging::Queue::Null)
      end
    end
  end
end
