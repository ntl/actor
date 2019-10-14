require_relative '../../test_init'

context "Queue Substitute, Empty Predicate" do
  substitute = Messaging::Queue::Substitute.new

  test "Substitute is empty" do
    assert substitute.empty?
  end
end
