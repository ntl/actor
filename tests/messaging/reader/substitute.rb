require_relative '../../test_init'

context "Reader substitute" do
  context "Reading" do
    context "Message has not been added" do
      substitute = Messaging::Reader::Substitute.new

      context "Wait is not requested (default)" do
        message = substitute.read

        test "Nothing is returned" do
          assert message.nil?
        end
      end

      context "Wait is requested" do
        test "Error is raised" do
          assert proc { substitute.read wait: true } do
            raises_error? Messaging::Reader::Substitute::Wait
          end
        end
      end
    end

    context "Message has been added" do
      context "Wait is not specified (default)" do
        substitute = Messaging::Reader::Substitute.new
        substitute.add_message 'some-message'

        message = substitute.read

        test "Message is returned" do
          assert message == 'some-message'
        end
      end

      context "Wait is specified" do
        substitute = Messaging::Reader::Substitute.new
        substitute.add_message 'some-message'

        message = substitute.read wait: true

        test "Message is returned" do
          assert message == 'some-message'
        end
      end
    end
  end

  context "Stopped predicate" do
    substitute = Messaging::Reader::Substitute.new

    context "Substitute has not been stopped" do
      test "False is returned" do
        refute substitute.stopped?
      end
    end

    context "Substitute has been stopped" do
      substitute.stop

      test "True is returned" do
        assert substitute.stopped?
      end
    end
  end
end
