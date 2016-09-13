require_relative '../test_init'

context "Thread substitute" do
  thread = Substitutes::Thread.new

  context do
    test "Status is running" do
      assert thread.status == 'run'
    end

    test "Alive predicate returns true" do
      assert thread.alive?
    end

    test "Stopped predicate returns false" do
      refute thread.stop?
    end

    test "Priority is 0" do
      assert thread.priority == 0
    end
  end

  context "Status is set to sleeping" do
    thread.status = 'sleep'

    test do
      assert thread.status == 'sleep'
    end

    test "Alive predicate returns true" do
      assert thread.alive?
    end

    test "Stopped predicate returns true" do
      assert thread.stop?
    end
  end

  context "Priority is set" do
    thread.priority = 11

    test do
      assert thread.priority == 11
    end
  end

  context "Name is set" do
    thread.name = 'some-thread'

    test do
      assert thread.name == 'some-thread'
    end
  end

  context "Thread is joined" do
    context "Limit is not specified" do
      executed_block = false

      thread = Substitutes::Thread.new do
        executed_block = true
      end

      return_value = thread.join

      test "Thread is returned" do
        assert return_value == thread
      end

      test "Block supplied on initialization is executed" do
        assert executed_block
      end
    end

    context "Limit is specified" do
      context "Limit is not exceeded" do
        executed_block = false

        thread = Substitutes::Thread.new do
          executed_block = true
        end

        return_value = thread.join

        test "Thread is returned" do
          assert return_value == thread
        end

        test "Block supplied on initialization is executed" do
          assert executed_block
        end
      end

      context "Limit is exceeded" do
        thread = Substitutes::Thread.new do
          sleep
        end

        return_value = thread.join Duration.millisecond

        test "Nothing is returned" do
          assert return_value == nil
        end
      end
    end
  end
end
