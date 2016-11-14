require_relative '../../test_init'

context "Actor is Started Via Class Method" do
  message = Controls::Message.example
  address = Controls::Actor::RequestResponse.start

  context "Actor is sent a message to which it responds" do
    reply_address = Messaging::Address.build
    request = Controls::Actor::RequestResponse::SomeRequest.new reply_address

    Messaging::Writer.(request, address)

    Fixtures::Timeout.("Actor eventually replies back") do
      reply = Messaging::Reader.(reply_address)

      assert reply == :some_response
    end
  end

  Messaging::Writer.(Messages::Stop, address)
end
