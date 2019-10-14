module Controls
  module Actor
    def self.example address=nil
      actor = Example.new
      actor.address = address if address
      actor
    end

    def self.define &block
      Class.new do
        include ::Actor
        include ::Actor::Controls
        include ::Actor::Module::SuspendResume::Controls

        class_exec &block if block
      end
    end

    def self.define_singleton *arguments, &block
      cls = define &block

      actor = cls.new *arguments

      actor
    end

    Example = self.define

    class Example
      def initialize
        @handled_messages = []
      end

      handle :some_message do |msg|
        @handled_messages << msg
        msg
      end

      def handled? msg
        @handled_messages.include? msg
      end
    end

    RequestResponse = define

    class RequestResponse
      handle :some_request do |msg|
        send.(:some_response, msg.reply_address)
      end

      SomeRequest = Struct.new :reply_address do
        include Messaging::Message
      end
    end

    CrashesImmediately = define do
      handle :start do
        raise Controls::Error.example
      end
    end

    StopsImmediately = define do
      handle :start do
        :stop
      end
    end

    module ActorStarted
      def self.example
        address = Address.example

        Actor::Messages::ActorStarted.new address
      end
    end

    module ActorCrashed
      def self.example
        error = Error.example

        Actor::Messages::ActorStarted.new error
      end
    end
  end
end
