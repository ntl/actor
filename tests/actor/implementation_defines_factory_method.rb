require_relative '../test_init'

context "Actor implementation defines a factory method (.build)" do
  actor_cls = Class.new do
    include Actor

    def initialize arg1, arg2
      @arg1, @arg2 = arg1, arg2
    end

    def self.build arg
      instance = new arg, 'arg2'
    end

    def constructed_by_factory_method?
      @arg2 == 'arg2'
    end

    def arg1_passed_in? value
      @arg1 == value
    end

    def action
      raise StopIteration
    end
  end

  _, actor, thread = actor_cls.start 'arg1', include: %i(actor thread)

  thread.join

  test "Factory method is used to construct actor" do
    assert actor.constructed_by_factory_method?
  end

  test "Arguments are passed to factory method" do
    assert actor.arg1_passed_in? 'arg1'
  end
end
