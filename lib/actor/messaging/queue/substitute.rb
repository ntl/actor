module Actor
  module Messaging
    module Queue
      class Substitute
        def initialize
          @enqueue_records = []
        end

        def enq message, non_block=nil
          non_block ||= false

          record = Record.new message, non_block

          @enqueue_records << record

          record
        end

        Record = Struct.new :message, :non_block

        module Assertions
          def enqueued? message, wait: nil
            @enqueue_records.each do |record|
              next unless message.nil? or record.message == message
              next unless wait.nil? or record.non_block == !wait

              return true
            end
          end
        end
      end
    end
  end
end
