require_relative '../test_init'

context "Ready predicate of future" do
  address, queue = Controls::Address.pair
  reader = Messaging::Read.new queue, address.stream

  future = Future.new reader

  context "Future message has not yet arrived" do
    test "False is returned" do
      refute future.ready?
    end
  end

  context "Future message has arrived" do
    message = Controls::Message.example

    queue.enq message

    test "True is returned" do
      assert future.ready?
    end
  end
end
