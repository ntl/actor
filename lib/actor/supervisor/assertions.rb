module Actor
  class Supervisor
    module Assertions
      def self.extended supervisor
        supervisor.instance_exec do
          assertions_module = publisher.class::Assertions
          publisher.extend assertions_module
        end
      end

      def registered_actor? actor
        publisher.registered? actor.address
      end

      def unregistered_actor? actor
        publisher.unregistered? actor.address
      end
    end
  end
end
