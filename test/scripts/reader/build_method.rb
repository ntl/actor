require_relative '../../test_init'

context "Reader, Build Method" do
  address = Controls::Address.example
  reader = Messaging::Reader.build address

  test "Reader is configured with queue of address" do
    assert reader do
      queue? address.queue
    end
  end
end
