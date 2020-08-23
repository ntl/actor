require_relative '../../test_init'

context "Queue, Dependency Module" do
  context "Class includes dependency module" do
    cls = Class.new do
      include Messaging::Queue::Dependency
    end

    context "Object is instantiated" do
      object = cls.new

      test "Queue attribute getter returns substitute queue" do
        assert object.queue.is_a?(Messaging::Queue::Substitute)
      end

      context "Queue attribute is specified" do
        queue = Controls::Queue.example

        object.queue = queue

        test "Queue attribute is set to specified queue" do
          assert object.queue == queue
        end
      end
    end
  end
end
