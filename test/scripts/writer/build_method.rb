require_relative '../scripts_init'

context "Writer, Build Method" do
  address1 = Address.build
  address2 = Address.build

  writer = Writer.build address1, address2

  test "Each specified address is registered with writer" do
    assert writer do
      registered? address1 and registered? address2
    end
  end
end
