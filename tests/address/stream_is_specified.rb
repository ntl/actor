require_relative '../test_init'

context "Stream is specified when address is constructed" do
  stream = Stream.new
  address = Address.new stream

  test "Stream is assigned" do
    assert address.stream == stream
  end
end
