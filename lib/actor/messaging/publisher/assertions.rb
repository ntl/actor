module Actor
  module Messaging
    class Publisher
      module Assertions
        def registered? address
          @addresses.include? address
        end
      end
    end
  end
end
