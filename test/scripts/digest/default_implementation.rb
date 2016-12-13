require_relative '../../test_init'

context "Digest, Default Implementation" do
  address = Controls::Address.example
  actor = Controls::Actor.example address

  test "Address is printed" do
    assert actor.digest == "#{actor.class}[address=#{address}]"
  end
end
