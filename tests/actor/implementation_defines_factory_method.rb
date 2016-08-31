require_relative '../test_init'

context "Actor implementation defines a factory method (.build)" do
  actor_cls = Controls::Actor::FactoryMethod

  _, actor, thread = Controls::Actor::FactoryMethod.start(
    'some-argument',
    include: %i(actor thread)
  )

  thread.join

  test "Factory method is used to construct actor" do
    assert actor.constructed_by_factory_method?
  end

  test "Arguments are passed to factory method" do
    assert actor.argument_passed_in? 'some-argument'
  end
end
