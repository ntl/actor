module Actor
  module Messaging
    class Address
      class None < Address
        def self.build
          id = ID.get
          queue = Queue.new

          new id, queue
        end

        def self.instance
          @instance ||= build
        end

        class Queue
          def deq non_block=nil
            sleep unless non_block == true
          end

          def enq msg, non_block=nil
          end
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
