require_relative '../../test_init'

context "Actor Instance is Started Via Class Method" do
  message = Controls::Message.example

  actor = Controls::Actor::RequestResponse.new
  actor.configure

  Actor::Start.(actor)

  context "Actor is sent a message to which it responds" do
    reply_address = Messaging::Address.build
    request = Controls::Actor::RequestResponse::SomeRequest.new reply_address

    Messaging::Send.(request, actor.address)

    Fixtures::Timeout.("Actor eventually replies back") do
      reply = Messaging::Read.(reply_address)

      assert reply == :some_response
    end
  end

  Messaging::Send.(Messages::Stop, actor.address)
end
