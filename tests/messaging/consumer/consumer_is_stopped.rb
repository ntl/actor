require_relative '../../test_init'

context "Stopping a consumer" do
  address = Messaging::Address.get
  consumer = Messaging::Consumer.build address

  consumer.stop

  test "Reader is stopped" do
    assert consumer.reader.stopped?
  end

  test "Consumer indicates it has stopped" do
    assert consumer.stopped?
  end

  test "Consumer count on address decreases" do
    assert address.consumer_count == 0
  end

  test "Address queue indicates it has no readers" do
    refute address.queue.readers?
  end
end
