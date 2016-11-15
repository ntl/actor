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
          read.instance_of? Messaging::Read
        end

        def writer_configured?
          write.instance_of? Messaging::Write
        end
      end
    end
  end
end
