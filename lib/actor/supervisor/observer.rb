module Actor
  class Supervisor
    module Observer
      def self.included cls
        cls.class_exec do
          include Module::Handler
        end
      end

      def update message
        handle message
      end
    end
  end
end
