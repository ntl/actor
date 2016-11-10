require_relative '../../test_init'

context "Writer Substitute" do
  address = Messaging::Address.build

  context "Written predicate" do
    context "No message has been written" do
      substitute = Messaging::Writer::Substitute.new

      test "Predicate returns false even if no constraints are specified" do
        refute substitute do
          written?
        end
      end
    end

    context "Message has been written" do
      context "Message constraint" do
        substitute = Messaging::Writer::Substitute.new
        substitute.write :some_message, address

        test "Predicate returns true if specified message matches written message" do
          assert substitute do
            written? :some_message
          end
        end

        test "Predicate returns fals if specified message does not match written message" do
          refute substitute do
            written? :other_message
          end
        end
      end

      context "Address constraint" do
        substitute = Messaging::Writer::Substitute.new
        substitute.write :some_message, address

        test "Predicate returns true if specified address matches address of write operation" do
          assert substitute do
            written? address: address
          end
        end

        test "Predicate returns false if specified address does not match address of write operation" do
          other_address = Messaging::Address.build

          refute substitute do
            written? address: other_address
          end
        end
      end

      context "Wait constraint" do
        context "Write operation was allowed to block" do
          substitute = Messaging::Writer::Substitute.new
          substitute.write :some_message, address

          test "Predicate returns true if specified wait value is true" do
            assert substitute do
              written? wait: true
            end
          end

          test "Predicate returns false if specified wait value is false" do
            refute substitute do
              written? wait: false
            end
          end
        end

        context "Write operation was not allowed to block" do
          substitute = Messaging::Writer::Substitute.new
          substitute.write :some_message, address, wait: false

          test "Predicate returns true if specified wait value is false" do
            assert substitute do
              written? wait: false
            end
          end

          test "Predicate returns false if specified wait value is true" do
            refute substitute do
              written? wait: true
            end
          end
        end
      end
    end
  end
end
