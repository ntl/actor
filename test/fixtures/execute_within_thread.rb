module Fixtures
  class ExecuteWithinThread
    include TestBench::Fixture

    attr_reader :block

    def initialize block
      @block = block
    end

    def self.call &block
      instance = new block
      instance.()
    end

    def call
      result = nil

      thread = Thread.new do
        sleep

        result = block.()
      end

      Thread.pass until thread.stop?

      thread.wakeup
      thread.join

      result
    end
  end
end
