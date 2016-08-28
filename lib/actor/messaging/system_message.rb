module Actor
  module Messaging
    module SystemMessage
      Pause = Class.new { include SystemMessage }
      Resume = Class.new { include SystemMessage }
      Stop = Class.new { include SystemMessage }

      class RecordStatus
        include SystemMessage

        attr_reader :reply_address
        attr_reader :status

        def initialize reply_address
          @reply_address = reply_address
          @status = Status.new
        end
      end

      class Status < OpenStruct
        include SystemMessage
      end
    end
  end
end
