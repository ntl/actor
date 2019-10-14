require_relative '../../test_init'

context "Reader, Build Method" do
  address = Controls::Address.example
  read = Messaging::Read.build address

  test "Reader is configured with queue of address" do
    assert read.queue?(address.queue)
  end
end
