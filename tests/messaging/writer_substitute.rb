require_relative '../test_init'

context "Writer substitute" do
  substitute = Actor::Messaging::Writer::Substitute.new

  context "Nothing was written" do
    context "Written predicate" do
      context "Block is not specified" do
        test "False is returned" do
          refute substitute, &:written?
        end
      end

      context "Block is specified" do
        test "False is returned" do
          refute substitute do
            written? { true }
          end
        end
      end
    end
  end

  context "Message was written" do
    substitute.('some-message')

    context "Written predicate" do
      context "Block is not specified" do
        test "True is returned" do
          assert substitute, &:written?
        end
      end

      context "Block is specified" do
        context "Block evaluates to something truthful" do
          test "True is returned" do
            assert substitute do
              written? { |message| message == 'some-message' }
            end
          end
        end

        context "Block evaluates to something false" do
          test "False is returned" do
            refute substitute do
              written? { |message| message == 'other-message' }
            end
          end
        end
      end
    end
  end
end
