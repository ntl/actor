require_relative '../scripts_init'

context "Address, None Singleton" do
  none = Messaging::Address::None.build

  test "ID is none" do
    assert none.id == '(none)'
  end

  context "Queue" do
    queue = none.queue

    context "Enqueuing" do
      test do
        refute proc { queue.enq :some_message } do
          raises_error?
        end
      end

      test "Non blocking mode" do
        refute proc { queue.enq :some_message, true } do
          raises_error?
        end
      end
    end

    context "Dequeuing" do
      test "Process is blocked" do
        thread = Thread.new do
          queue.deq
          fail
        end

        Thread.pass until thread.stop?
        thread.kill
        thread.join

        assert thread.status == false
      end

      test "Dequeuing (non blocking mode)" do
        message = queue.deq true

        assert message == nil
      end
    end
  end
end
