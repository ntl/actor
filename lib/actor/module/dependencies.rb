module Actor
  module Module
    module Dependencies
      def self.included receiver
        receiver.class_exec do
          include Messaging::Address::Dependency
          include Messaging::Read::Dependency
          include Messaging::Send::Dependency

          prepend Configure
        end
      end

      def configure
      end

      def dependencies_configured?
        address_configured? and reader_configured? and send_configured?
      end

      def address_configured?
        address.instance_of? Messaging::Address
      end

      def reader_configured?
        read.instance_of? Messaging::Read
      end

      def send_configured?
        send.instance_of? Messaging::Send
      end

      module Configure
        def configure
          self.address = Messaging::Address.build
          self.read = Messaging::Read.build address
          self.send = Messaging::Send.new

          super
        end
      end
    end
  end
end
