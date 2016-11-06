require_relative '../scripts_init'

context "Publisher, Build Method" do
  address1 = Address.build
  address2 = Address.build

  publisher = Publisher.build address1, address2

  test "Each specified address is registered with publisher" do
    assert publisher do
      registered? address1 and registered? address2
    end
  end
end
