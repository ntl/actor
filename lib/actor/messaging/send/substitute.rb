module Actor
  module Messaging
    class Send
      class Substitute
        attr_reader :records

        def initialize
          @records = []
        end

        def call message, queue, wait: nil
          wait = false if wait.nil?

          record = Record.new message, queue, wait

          records << record
        end

        def sent? message=nil, queue: nil, wait: nil
          records.each do |record|
            next unless message.nil? or record.message? message
            next unless queue.nil? or record.queue == queue
            next unless wait.nil? or record.wait == wait

            return true
          end

          false
        end

        Record = Struct.new :message, :queue, :wait do
          def message? pattern
            return true if message == pattern

            if pattern.is_a? Symbol and message.is_a? Message
              message.message_name == pattern
            end
          end
        end

        singleton_class.send :alias_method, :build, :new # subst-attr compat
      end
    end
  end
end
