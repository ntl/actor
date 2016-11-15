module Actor
  module Module
    module Dependencies
      def self.included receiver
        receiver.class_exec do
          include Messaging::Address::Dependency
          include Messaging::Read::Dependency
          include Messaging::Write::Dependency

          prepend Configure

          IncludeAssertions.(Assertions, self)
        end
      end

      def configure
      end

      module Configure
        def configure
          self.address = Messaging::Address.build
          self.read = Messaging::Read.build address
          self.write = Messaging::Write.new

          super
        end
      end
    end
  end
end
