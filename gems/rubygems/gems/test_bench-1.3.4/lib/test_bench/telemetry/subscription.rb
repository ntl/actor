module TestBench
  class Telemetry
    class Subscription
      attr_reader :subscriber

      def initialize subscriber
        @subscriber = subscriber
      end

      def update event, argument=nil
        return unless subscriber.respond_to? event

        method = subscriber.method event

        if method.arity == 0
          subscriber.public_send event
        else
          subscriber.public_send event, argument
        end
      end
    end
  end
end
