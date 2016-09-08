require_relative '../test_init'

context "Inert substitute for write operation" do
  substitute_writer = Actor::Messaging::Write::Substitute.new

  context "Message has not been written to substitute" do
    test "Written predicate returns false if no arguments are supplied" do
      refute substitute_writer, &:written?
    end

    test "Written predicate returns false even if block evaluates truthfully" do
      refute substitute_writer do
        written? { true }
      end
    end
  end

  context "Message has been written to substitute" do
    message = Controls::Message.example
    address = Controls::Address.example

    substitute_writer.(message, address)

    test "Written predicate returns true if no arguments are supplied" do
      assert substitute_writer, &:written?
    end

    test "Written predicate returns true if specified message was written" do
      assert substitute_writer do
        written? message
      end
    end

    test "Written predicate returns false if specified message was not written" do
      refute substitute_writer do
        written? Controls::Message::Other.example
      end
    end

    test "Written predicate returns true if block evaluates truthfully" do
      assert substitute_writer do
        written? { true }
      end
    end

    test "Written predicate returns false if block does not evaluate truthfully" do
      refute substitute_writer do
        written? { false }
      end
    end

    test "Message and address are passed to block of written predicate" do
      assert substitute_writer do
        msg, addr = nil, nil

        written? { |_msg, _addr| msg, addr = _msg, _addr }

        msg == message && addr == address
      end
    end
  end
end
