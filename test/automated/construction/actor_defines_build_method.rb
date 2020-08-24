require_relative '../../test_init'

context "Actor Defines a Build Class Method" do
  actor_cls = Class.new do
    include Actor

    attr_reader :arg

    def initialize(arg)
      @arg = arg
    end

    attr_accessor :build_method_invoked

    def self.build(arg)
      instance = new(arg)
      instance.build_method_invoked = true
      instance
    end
  end

  actor = Actor::Build.(actor_cls, :some_arg)

  test "Build method is invoked" do
    assert actor.build_method_invoked
  end

  test "Supplied arguments are passed to build class method" do
    assert actor.arg == :some_arg
  end
end
