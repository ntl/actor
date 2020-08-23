require_relative '../../test_init'

context "Publisher, Build Method" do
  queue1 = Controls::Queue.example
  queue2 = Controls::Queue::Other.example

  publish = Messaging::Publish.build queue1, queue2

  test "Each specified queue is registered with publisher" do
    assert publish.registered?(queue1)
    assert publish.registered?(queue2)
  end
end
