require_relative '../../test_init'

context "Actor is Started Via Class Method" do
  message = Controls::Message.example
  address = Controls::Actor::RequestResponse.start

  context "Actor is sent a message to which it responds" do
    reply_address = Messaging::Address.build
    request = Controls::Actor::RequestResponse::SomeRequest.new reply_address

    Messaging::Send.(request, address)

    Fixtures::Timeout.("Actor eventually replies back") do
      reply = Messaging::Read.(reply_address)

      assert reply == :some_response
    end
  end

  Messaging::Send.(Messages::Stop, address)
end
