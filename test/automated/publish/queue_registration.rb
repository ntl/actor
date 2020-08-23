require_relative '../../test_init'

context "Publisher, Registering and Unregistering Queues" do
  publish = Messaging::Publish.new

  queue = Controls::Queue.example

  context "Queue is registered with publisher" do
    publish.register queue

    test "Publisher has registered queue" do
      assert publish.registered?(queue)
    end
  end

  context "Queue is unregistered from publisher" do
    publish.unregister queue

    test "Publisher has no longer registered queue" do
      refute publish.registered?(queue)
    end
  end
end
