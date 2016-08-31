require_relative '../test_init'

context "Actor status is queried" do
  address, thread = Controls::Actor::Example.start include: %i(thread)

  reply_address = Messaging::Address.build
  reader = Messaging::Reader.build reply_address

  record_status_message = Message::RecordStatus.new reply_address
  Messaging::Writer.(record_status_message, address)

  status = reader.(wait: true)

  test "Executions count is copied" do
    assert status.executions.is_a? Integer
  end

  test "Actor state is copied" do
    assert status.state == :running
  end

  test "Actor class name is copied" do
    assert status.actor_class == 'Actor::Controls::Actor::Example'
  end
end
