require_relative '../scripts_init'

context "Actor Defines Specialized Configure Method" do
  actor_cls = Fixtures::Controls::Actor.define do
    attr_accessor :configure_method_invoked

    def configure
      self.configure_method_invoked = true
    end
  end

  actor = Build.(actor_cls)

  test "Specialized configure method is invoked" do
    assert actor.configure_method_invoked
  end

  test "Actor dependencies are still configured" do
    assert actor, &:dependencies_configured?
  end
end
