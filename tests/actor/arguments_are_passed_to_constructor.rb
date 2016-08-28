require_relative '../test_init'

context "Arguments passed to start actuator are forwarded to constructor" do
  actor_cls = Class.new do
    attr_reader :req, :opt, :keyreq, :key, :block

    def initialize req, opt=nil, keyreq:, key: nil, &block
      @req, @opt, @keyreq, @key, @block = req, opt, keyreq, key, block
    end

    def action
      raise StopIteration
    end
  end

  block = proc { 'block' }

  _, actor, thread = actor_cls.start 'req', 'opt', keyreq: 'keyreq', key: 'key', include: %i(actor thread), &block

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
