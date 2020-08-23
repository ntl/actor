require_relative '../../test_init'

context "Actor Instance is Started Via Class Method" do
  message = Controls::Message.example

  actor = Controls::Actor::RequestResponse.new
  actor.configure

  Actor::Start.(actor)

  context "Actor is sent a message to which it responds" do
    reply_queue = Messaging::Queue.get
    request = Controls::Actor::RequestResponse::SomeRequest.new reply_queue

    Messaging::Send.(request, actor.queue)

    Fixtures::Timeout.("Actor eventually replies back") do
      reply = Messaging::Read.(reply_queue)

      assert reply == :some_response
    end
  end

  Messaging::Send.(Messages::Stop, actor.queue)
end
