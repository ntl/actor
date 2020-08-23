require_relative '../../test_init'

context "Reader, Build Method" do
  queue = Controls::Queue.example
  read = Messaging::Read.build queue

  test "Reader is configured with queue of queue" do
    assert read.queue?(queue)
  end
end
