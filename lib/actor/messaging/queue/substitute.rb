module Actor
  module Messaging
    module Queue
      class Substitute
        def initialize
          @enqueue_records = []
          @read_message = nil
        end

        def self.build
          instance = new
          instance.extend Controls
          instance
        end

        def deq non_block=nil
          non_block ||= false

          if value = @read_message
            @read_message = nil
            return value
          end

          if non_block
            nil
          else
            raise WouldBlockError
          end
        end

        def enq message, non_block=nil
          non_block ||= false

          record = Record.new message, non_block

          @enqueue_records << record

          record
        end

        Record = Struct.new :message, :non_block

        WouldBlockError = Class.new StandardError

        module Controls
          attr_writer :read_message
        end

        module Assertions
          def enqueued? message=nil, wait: nil
            @enqueue_records.each do |record|
              next unless message.nil? or record.message == message
              next unless wait.nil? or record.non_block == !wait

              return true
            end

            false
          end

          def read_message?
            not @read_message.nil?
          end
        end
      end
    end
  end
end
