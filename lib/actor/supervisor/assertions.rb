module Actor
  class Supervisor
    module Assertions
      def self.extended supervisor
        supervisor.instance_exec do
          assertions_module = publish.class::Assertions
          publish.extend assertions_module
        end
      end

      def registered_actor? actor
        publish.registered? actor.address
      end

      def unregistered_actor? actor
        publish.unregistered? actor.address
      end
    end
  end
end
