module Actor
  module Messaging
    class Publish
      module Assertions
        def registered? address
          addresses.include? address
        end
      end
    end
  end
end
