require_relative '../test_init'

context "Start message is handled by router" do
  router = Router.new

  test "Continue message is returned" do
    return_value = router.handle Messages::Start.new

    assert return_value == :continue
  end
end
