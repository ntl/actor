require_relative '../test_init'

context "Remove route message is handled by router" do
  router = Router.new

  reader = Messaging::Read::Substitute.new
  output_address = Controls::Address.example
  router.add reader, output_address

  remove_route = Router::RemoveRoute.new reader, output_address

  router.handle remove_route

  test "Route that maps the reader to the output address is removed" do
    refute router do
      route? reader, output_address
    end
  end
end
