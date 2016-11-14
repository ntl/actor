module Fixtures
  module Controls
    module Address
      def self.example id=nil
        id ||= ID.get 1

        queue = ::Actor::Messaging::Address::None::Queue.new

        ::Actor::Messaging::Address.new id, queue
      end

      module ID
        def self.get i=nil
          i ||= 0

          first_word = i.to_s.rjust 8

          "#{first_word}-0000-4000-8000-000000000000"
        end
      end

      module Supervisor
        def self.example
          id = ID.get 2

          Address.example id
        end
      end

      module Other
        def self.example
          id = ID.get 3

          Address.example id
        end
      end
    end
  end
end
