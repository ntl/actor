module Fixtures
  class ExecuteWithinThread
    include TestBench::Fixture

    attr_reader :block
    attr_reader :thread_group

    def initialize block, thread_group
      @block = block
      @thread_group = thread_group
    end

    def self.call thread_group=nil, &block
      thread_group ||= ThreadGroup::Default

      instance = new block, thread_group
      instance.()
    end

    def call
      result = nil

      thread = Thread.new do
        sleep

        result = block.()
      end

      Thread.pass until thread.stop?

      thread_group.add thread

      thread.wakeup
      thread.join

      result
    end
  end
end
