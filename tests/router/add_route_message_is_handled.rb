require_relative '../test_init'

context "Add route message is handled by router" do
  router = Router.new

  reader = Messaging::Read::Substitute.new
  output_address = Controls::Address.example
  add_route = Router::AddRoute.new reader, output_address

  router.handle add_route

  test "Route is added that maps the reader to the output address" do
    assert router do
      route? reader, output_address
    end
  end
end
