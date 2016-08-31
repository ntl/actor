module Actor
  module TestFixtures
    class SampleActorStatus
      include TestBench::Fixture

      attr_reader :reader
      attr_reader :reply_address
      attr_reader :writer

      def initialize writer, reply_address, reader
        @reader = reader
        @reply_address = reply_address
        @writer = writer
      end

      def self.call prose, address:, test:
        reply_address = Messaging::Address.build
        reader = Messaging::Reader.build reply_address

        writer = Messaging::Writer.build address

        instance = new writer, reply_address, reader
        instance.(prose, &test)
      end

      def call test_prose, &block
        writer.(record_status_message)

        status_0 = reader.(wait: true)

        writer.(record_status_message)

        status_1 = reader.(wait: true)

        test test_prose do
          block.(status_1, status_0)
        end
      end

      def record_status_message
        Message::RecordStatus.new reply_address
      end
    end
  end
end
