require_relative '../../test_init'

context "Reader Substitute" do
  context "Message is not added to substitute" do
    substitute = Messaging::Read::Substitute.build

    context "Reading messages (wait is not specified)" do
      test "WouldBlockError is raised" do
        assert proc { substitute.() } do
          raises_error? Messaging::Queue::Substitute::WouldBlockError
        end
      end
    end

    context "Reading messages (wait is disabled)" do
      message = substitute.(wait: false)

      test "Nothing is returned" do
        assert message.nil?
      end
    end
  end

  context "Message is added to substitute" do
    substitute = Messaging::Read::Substitute.build
    substitute.add :some_message

    context "Message is read" do
      message = substitute.()

      test "Specified message is returned" do
        assert message == :some_message
      end
    end
  end
end
