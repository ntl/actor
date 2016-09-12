require_relative '../test_init'

context "Handler macro defines a handler method" do
  cls = Class.new do
    include Actor

    handle :some_message do
      @handler_executed = true
    end

    def handler_executed?
      @handler_executed
    end
  end

  actor = cls.new

  test "Method named after specified message type is defined" do
    assert actor.respond_to? :handle_some_message

    actor.handle_some_message

    assert actor.handler_executed?
  end
end
