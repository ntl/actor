module Actor
  Address = Struct.new :stream, :uuid do
    def self.build stream=nil
      stream ||= Stream.new

      uuid = SecureRandom.uuid

      instance = new stream, uuid
      instance
    end
  end

  class Address
    module Substitute
      def self.build
        stream = Stream::Null

        Address.build stream
      end
    end
  end
end
