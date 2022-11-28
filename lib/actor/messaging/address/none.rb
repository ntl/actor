module Actor
  module Messaging
    class Address
      class None < Address
        def self.build
          id = ID.get
          queue = Queue::Substitute.build

          new(id, queue)
        end

        def self.instance
          @instance ||= build
        end

        module ID
          def self.get
            '(none)'
          end
        end
      end
    end
  end
end
