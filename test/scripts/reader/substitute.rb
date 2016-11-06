require_relative '../scripts_init'

context "Reader Substitute" do
  context "Message is not specified for substitute" do
    substitute = Messaging::Reader::Substitute.new

    context "Reading messages (wait is not specified)" do
      test "WouldBlockError is raised" do
        assert proc { substitute.read } do
          raises_error? Messaging::Reader::Substitute::WouldBlockError
        end
      end
    end

    context "Reading messages (wait is disabled)" do
      message = substitute.read wait: false

      test "Nothing is returned" do
        assert message.nil?
      end
    end
  end

  context "Message is specified for substitute" do
    substitute = Messaging::Reader::Substitute.new
    substitute.message = :some_message

    context "Message is read" do
      message = substitute.read

      test "Specified message is returned" do
        assert message == :some_message
      end
    end
  end
end
