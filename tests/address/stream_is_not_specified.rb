require_relative '../test_init'

context "Stream is not specified when address is constructed" do
  address = Address.build

  test "Stream is assigned" do
    assert address.stream do
      instance_of? Stream
    end
  end
end
