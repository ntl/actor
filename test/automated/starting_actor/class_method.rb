require_relative '../../test_init'

context "Actor is Started Via Class Method" do
  message = Controls::Message.example
  queue = Controls::Actor::RequestResponse.start

  context "Actor is sent a message to which it responds" do
    reply_queue = Messaging::Queue.get
    request = Controls::Actor::RequestResponse::SomeRequest.new reply_queue

    Messaging::Send.(request, queue)

    Fixtures::Timeout.("Actor eventually replies back") do
      reply = Messaging::Read.(reply_queue)

      assert reply == :some_response
    end
  end

  Messaging::Send.(Messages::Stop, queue)
end
