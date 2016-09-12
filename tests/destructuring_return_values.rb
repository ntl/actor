require_relative './test_init'

context "Destructuring return values" do
  primary_return_value = Object.new

  context "No additional values are requested to be included" do
    return_value = Destructure.(primary_return_value)

    test "Primary return value is returned by itself" do
      assert return_value == primary_return_value
    end
  end

  context "An additional value is requested" do
    var1 = Object.new

    return_value, var1_value = Destructure.(
      primary_return_value,
      :var1,
      var1: var1
    )

    test "Primary return value is returned" do
      assert return_value == primary_return_value
    end

    test "Additional requested value is returned" do
      assert var1_value == var1
    end
  end

  context "Multiple additional values are requested" do
    var1 = Object.new
    var2 = Object.new

    return_value, var1_value, var2_value = Destructure.(
      primary_return_value,
      %i(var1 var2),
      var1: var1,
      var2: var2
    )

    test "Primary return value is returned" do
      assert return_value == primary_return_value
    end

    test "Additional requested values are returned" do
      assert var1_value == var1
      assert var2_value == var2
    end
  end

  context "Return value not present in binding is requested" do
    assert proc { Destructure.(Object.new, :other_val, val: 'some-value') } do
      raises_error? Destructure::Error
    end
  end
end
