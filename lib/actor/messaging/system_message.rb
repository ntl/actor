module Actor
  module Messaging
    module SystemMessage
      Pause = Class.new
      Resume = Class.new
      Stop = Class.new

      class RecordStatus
        attr_reader :reply_address
        attr_reader :status

        def initialize reply_address
          @reply_address = reply_address
          @status = Status.new
        end
      end

      class Status < OpenStruct
      end
    end
  end
end
