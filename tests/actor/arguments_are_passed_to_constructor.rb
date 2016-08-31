require_relative '../test_init'

context "Arguments passed to start actuator are forwarded to constructor" do
  _, actor, thread = Controls::Actor::ConstructorArguments.start(
    'req',
    'opt',
    keyreq: 'keyreq',
    key: 'key',
    include: %i(actor thread)
  ) do 'block' end

  thread.join

  test "Required arguments are forwarded" do
    assert actor.req == 'req'
  end

  test "Optional arguments are forwarded" do
    assert actor.opt == 'opt'
  end

  test "Keyword arguments are forwarded" do
    assert actor.keyreq == 'keyreq'
  end

  test "Optional keyword arguments are forwarded" do
    assert actor.key == 'key'
  end

  test "Block is forwarded" do
    assert actor.block.() == 'block'
  end
end
