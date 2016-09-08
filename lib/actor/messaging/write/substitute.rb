module Actor
  module Messaging
    class Write
      class Substitute
        attr_reader :records

        def initialize
          @records = []
        end

        def call message, address
          record = Record.new message, address

          records << record

          record
        end

        Record = Struct.new :message, :address

        singleton_class.send :alias_method, :build, :new

        module Assertions
          def written? message=nil, &block
            if message.nil?
              block ||= proc { true }
            else
              block ||= proc { |msg| msg == message }
            end

            records.any? do |record|
              block.(record.message, record.address)
            end
          end
        end
      end
    end
  end
end
