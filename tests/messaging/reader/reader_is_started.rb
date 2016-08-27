require_relative '../../test_init'

context "Starting a reader" do
  address = Messaging::Address.get
  reader = Messaging::Reader.build address

  test "Reader count on address is increased" do
    assert address.reader_count == 1
  end

  test "Address queue indicates it has a reader" do
    assert address.queue.readers?
  end
end
