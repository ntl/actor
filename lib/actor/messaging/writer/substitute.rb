module Actor
  module Messaging
    class Writer
      class Substitute
        def initialize
          @records = []
        end

        singleton_class.send :alias_method, :build, :new

        def write message, address, wait: nil
          wait = true if wait.nil?

          record = Record.new message, address, wait

          @records << record
        end

        Record = Struct.new :message, :address, :wait do
          def message? pattern
            return true if message == pattern

            if pattern.is_a? Symbol and message.is_a? Message
              message.message_name == pattern
            end
          end
        end

        module Assertions
          def written? message=nil, address: nil, wait: nil
            @records.each do |record|
              next unless message.nil? or record.message? message
              next unless address.nil? or record.address == address
              next unless wait.nil? or record.wait == wait

              return true
            end

            false
          end
        end
      end
    end
  end
end
