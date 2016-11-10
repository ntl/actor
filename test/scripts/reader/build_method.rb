require_relative '../../test_init'

context "Reader, Build Method" do
  address = Messaging::Address.build
  reader = Messaging::Reader.build address

  test "Reader is configured with queue of address" do
    assert reader do
      queue? address.queue
    end
  end
end
