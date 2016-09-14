require_relative '../test_init'

context "Router is started" do
  router_address, thread, router = Router.start include: %i(thread actor)

  context "Route is added" do
    reader = Messaging::Read::Substitute.new
    output_address = Controls::Address.example

    add_route = Router::AddRoute.new reader, output_address

    Messaging::Write.(add_route, router_address)
  end

  context "Router is stopped" do
    Messaging::Write.(Messages::Stop.new, router_address)

    test "Thread eventually exits gracefully" do
      return_value = thread.join Duration.millisecond

      assert return_value == thread
      assert thread.status == false
    end
  end
end
