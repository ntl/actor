module Actor
  module Messaging
    module Queue
      class Substitute
        def initialize
          @enqueued_records = []
        end

        def self.build
          instance = new
          instance
        end

        def deq(non_block=nil)
          if non_block
            raise ThreadError
          else
            raise WouldBlockError
          end
        end

        def empty?
          true
        end

        def enq(message, non_block=nil)
          non_block = false if non_block.nil?

          record = Record.new(message, non_block)
          @enqueued_records << record
          record
        end

        def enqueued?(message=nil, wait: nil)
          @enqueued_records.any? do |record|
            next unless message.nil? or record.message == message
            next unless wait.nil? or record.non_block == !wait

            true
          end
        end

        def max
          Float::INFINITY
        end

        def size
          0
        end

        WouldBlockError = Class.new(StandardError)

        Record = Struct.new(:message, :non_block)
        singleton_class.send(:alias_method, :build, :new) # subst-attr compat
      end
    end
  end
end
