module Actor
  module Module
    module Dependencies
      module Assertions
        def dependencies_configured?
          address_configured? and reader_configured? and writer_configured?
        end

        def address_configured?
          address.instance_of? Messaging::Address
        end

        def reader_configured?
          reader.instance_of? Messaging::Reader
        end

        def writer_configured?
          writer.instance_of? Messaging::Writer
        end
      end
    end
  end
end
