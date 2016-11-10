require_relative '../../test_init'

context "Message Match Predicate" do
  context "Specified object includes message module" do
    message = Object.new
    message.extend Messaging::Message

    test "Predicate returns true" do
      assert Messaging::Message === message
    end
  end

  context "Specified object is a symbol" do
    test "Predicate returns true" do
      assert Messaging::Message === :some_message
    end
  end

  context "Specified object is any other object" do
    test "Predicate returns false" do
      refute Messaging::Message === Object.new
    end
  end
end
