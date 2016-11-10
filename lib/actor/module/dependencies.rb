module Actor
  module Module
    module Dependencies
      def self.included receiver
        receiver.class_exec do
          include Messaging::Address::Dependency
          include Messaging::Reader::Dependency
          include Messaging::Writer::Dependency

          prepend Configure

          IncludeAssertions.(Assertions, self)
        end
      end

      def configure
      end

      module Configure
        def configure
          self.address = Messaging::Address.build
          self.reader = Messaging::Reader.build address
          self.writer = Messaging::Writer.new

          super
        end
      end
    end
  end
end
