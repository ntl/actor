require_relative '../../test_init'

context "Publisher Substitute" do
  address = Messaging::Address.build

  context "Address registration" do
    substitute = Messaging::Publisher::Substitute.new

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
      other_address = Messaging::Address.build

      refute substitute do
        registered? other_address
      end
    end
  end

  context "Address unregistration" do
    substitute = Messaging::Publisher::Substitute.new

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
      other_address = Messaging::Address.build

      refute substitute do
        unregistered? other_address
      end
    end
  end

  context "Publishing messages (wait is not specified)" do
    substitute = Messaging::Publisher::Substitute.new

    context "No message has been published" do
      test "Published predicate without argument returns false" do
        refute substitute do
          published?
        end
      end
    end

    substitute.publish :some_message

    test "Published predicate without argument returns true" do
      assert substitute do
        published?
      end
    end

    test "Published predicate returns true if argument matches published message" do
      assert substitute do
        published? :some_message
      end
    end

    test "Published predicate returns false if argument does not match published message" do
      refute substitute do
        published? :other_message
      end
    end

    test "Published predicate returns true if message argument matches and operation was expected to allow blocking" do
      assert substitute do
        published? :some_message, wait: true
      end
    end

    test "Published predicate returns false if message argument matches and operation was expected to avoid blocking" do
      refute substitute do
        published? :some_message, wait: false
      end
    end
  end

  context "Publishing messages (wait is disabled)" do
    substitute = Messaging::Publisher::Substitute.new

    substitute.publish :some_message, wait: false

    test "Published predicate returns true if argument matches published message" do
      assert substitute do
        published? :some_message
      end
    end

    test "Published predicate returns true if message argument matches and operation was expected to avoid blocking" do
      assert substitute do
        published? :some_message, wait: false
      end
    end

    test "Published predicate returns false if message argument matches and operation was expected to allow blocking" do
      assert substitute do
        published? :some_message, wait: false
      end
    end
  end
end
