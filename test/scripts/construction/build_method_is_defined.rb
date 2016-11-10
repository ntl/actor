require_relative '../../test_init'

context "Actor Defines a Build Class Method" do
  actor_cls = Struct.new :arg do
    include Actor

    singleton_class.send :attr_accessor, :build_method_invoked

    def self.build arg
      self.build_method_invoked = true
      new arg
    end
  end

  actor = Actor::Build.(actor_cls, :some_arg)

  test "Build method is invoked" do
    assert actor_cls.build_method_invoked
  end

  test "Supplied arguments are passed to build class method" do
    assert actor.arg == :some_arg
  end
end
