module Actor
  module Messaging
    class Address
      module Dependency
        attr_writer :address

        def address
          @address ||= Address::None.instance
        end
      end
    end
  end
end
