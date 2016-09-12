require_relative '../test_init'

context "Thread group substitute" do
  context "Thread is added" do
    thread_group = Substitutes::ThreadGroup.new

    thread_group.add :some_thread

    test "List includes thread" do
      assert thread_group.list == [:some_thread]
    end
  end

  context "Group is enclosed" do
    thread_group = Substitutes::ThreadGroup.new

    thread_group.enclose

    test "Enclosed predicate returns true" do
      assert thread_group.enclosed?
    end
  end

  context "Group is not enclosed" do
    thread_group = Substitutes::ThreadGroup.new

    test "Enclosed predicate returns false" do
      refute thread_group.enclosed?
    end
  end
end
