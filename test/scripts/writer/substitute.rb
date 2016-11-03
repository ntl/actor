require_relative '../scripts_init'

context "Writer Substitute" do
  address = Address.build

  context "Address registration" do
    substitute = Writer::Substitute.new

    context "No address has been registered" do
      test "Registered predicate without argument returns false" do
        refute substitute do
          registered?
        end
      end
    end

    substitute.register address

    test "Registered predicate without argument returns true" do
      assert substitute do
        registered?
      end
    end

    test "Registered predicate returns true if argument matches address" do
      assert substitute do
        registered? address
      end
    end

    test "Registered predicate returns false if argument does not match address" do
      other_address = Address.build

      refute substitute do
        registered? other_address
      end
    end
  end

  context "Address unregistration" do
    substitute = Writer::Substitute.new

    context "No address has been registered" do
      test "Unregistered predicate without argument returns false" do
        refute substitute do
          unregistered?
        end
      end
    end

    substitute.unregister address

    test "Unregistered predicate without argument returns true" do
      assert substitute do
        unregistered?
      end
    end

    test "Unregistered predicate returns true if argument matches address" do
      assert substitute do
        unregistered? address
      end
    end

    test "Registered predicate returns false if argument does not match address" do
      other_address = Address.build

      refute substitute do
        unregistered? other_address
      end
    end
  end

  context "Writing messages (wait is not specified)" do
    substitute = Writer::Substitute.new

    context "No message has been written" do
      test "Written predicate without argument returns false" do
        refute substitute do
          written?
        end
      end
    end

    substitute.write :some_message

    test "Written predicate without argument returns true" do
      assert substitute do
        written?
      end
    end

    test "Written predicate returns true if argument matches written message" do
      assert substitute do
        written? :some_message
      end
    end

    test "Written predicate returns false if argument does not match written message" do
      refute substitute do
        written? :other_message
      end
    end

    test "Written predicate returns true if message argument matches and write was expected to allow blocking" do
      assert substitute do
        written? :some_message, wait: true
      end
    end

    test "Written predicate returns false if message argument matches and write was expected to avoid blocking" do
      refute substitute do
        written? :some_message, wait: false
      end
    end
  end

  context "Writing messages (wait is disabled)" do
    substitute = Writer::Substitute.new

    substitute.write :some_message, wait: false

    test "Written predicate returns true if argument matches written message" do
      assert substitute do
        written? :some_message
      end
    end

    test "Written predicate returns true if message argument matches and write was expected to avoid blocking" do
      assert substitute do
        written? :some_message, wait: false
      end
    end

    test "Written predicate returns false if message argument matches and write was expected to allow blocking" do
      assert substitute do
        written? :some_message, wait: false
      end
    end
  end
end
