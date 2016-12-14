module Actor
  module Messaging
    class Address
      module Dependency
        attr_writer :address

        def address
          @address ||= Address::None.build
        end
      end
    end
  end
end
