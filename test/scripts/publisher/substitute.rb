require_relative '../../test_init'

context "Publisher Substitute" do
  address = Controls::Address.example

  context "Address registration" do
    substitute = Messaging::Publish::Substitute.new

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
      other_address = Controls::Address::Other.example

      refute substitute do
        registered? other_address
      end
    end
  end

  context "Address unregistration" do
    substitute = Messaging::Publish::Substitute.new

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
      other_address = Controls::Address::Other.example

      refute substitute do
        unregistered? other_address
      end
    end
  end

  
  context "Publishing messages" do
    context "No message has been published" do
      substitute = Messaging::Publish::Substitute.new

      test "Published predicate without argument returns false" do
        refute substitute do
          published?
        end
      end
    end

    context "Message has been published" do
      context do
        substitute = Messaging::Publish::Substitute.new

        substitute.(:some_message)

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
      end

      [["Wait was not specified at callsite", nil], ["Wait was disabled at callsite", false]].each do |prose, wait|
        context prose do
          substitute = Messaging::Publish::Substitute.new

          substitute.(:some_message, wait: wait)

          test "Published predicate returns true if wait value is false" do
            assert substitute do
              published? :some_message, wait: false
            end
          end

          test "Published predicate returns false if wait value is true" do
            refute substitute do
              published? :some_message, wait: true
            end
          end
        end
      end

      context "Wait was enabled at callsite" do
        substitute = Messaging::Publish::Substitute.new

        substitute.(:some_message, wait: true)

        test "Published predicate returns true if wait value is true" do
          assert substitute do
            published? :some_message, wait: true
          end
        end

        test "Published predicate returns false if wait value is false" do
          refute substitute do
            published? :some_message, wait: false
          end
        end
      end
    end
  end
end
