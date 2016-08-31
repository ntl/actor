require_relative '../../test_init'

context "Stopping a reader" do
  address = Messaging::Address.build
  reader = Messaging::Reader.build address

  reader.stop

  test "Reader indicates it has stopped" do
    assert reader.stopped?
  end

  test "Address queue reader is stopped" do
    assert reader.queue_reader.stopped?
  end

  test "Reader count on address decreases" do
    assert address.reader_count == 0
  end

  test "Address queue indicates it has no readers" do
    refute address.queue.readers?
  end
end
