module Actor
  module Message
    Pause = Class.new { include Message }
    Resume = Class.new { include Message }
    Stop = Class.new { include Message }

    class RecordStatus
      include Message

      attr_reader :reply_address
      attr_reader :status

      def initialize reply_address
        @reply_address = reply_address
        @status = Status.new
      end
    end

    class Status < OpenStruct
      include Message
    end
  end
end
