require_relative '../../test_init'

context "Starting a consumer" do
  address = Messaging::Address.get
  consumer = Messaging::Consumer.build address

  test "Consumer count on address is increased" do
    assert address.consumer_count == 1
  end

  test "Address queue indicates it has a reader" do
    assert address.queue.readers?
  end
end
