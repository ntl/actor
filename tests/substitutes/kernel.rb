require_relative '../test_init'

context "Kernel substitute" do
  context "Substitute has not been instructed to sleep" do
    kernel_substitute = Substitutes::Kernel.new

    test "False is returned by predicate if no arguments are specified" do
      refute kernel_substitute, &:slept?
    end

    test "False is returned by predicate if any argument is specified" do
      refute kernel_substitute do
        slept? 1
      end
    end
  end

  context "Substitute has been instructed to sleep" do
    kernel_substitute = Substitutes::Kernel.new

    kernel_substitute.sleep 1

    test "True is returned by predicate if no arguments are specified" do
      assert kernel_substitute, &:slept?
    end

    test "False is returned by predicate if specified argument matches duration" do
      assert kernel_substitute do slept? 1 end
    end

    test "False is returned by predicate if specified argument does not match duration" do
      refute kernel_substitute do slept? 11 end
    end
  end
end
