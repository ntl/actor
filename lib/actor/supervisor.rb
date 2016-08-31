module Actor
  class Supervisor
    attr_reader :actors
    attr_writer :exception_notifier

    def initialize
      @actors = Set.new
    end

    def add address, thread
      actor = Actor.new address, thread

      actors << actor

      actor
    end

    def remove address
      actors.delete_if do |actor|
        actor.address == address
      end
    end

    def broadcast message
      addresses = actors.map &:address

      addresses.each do |address|
        Messaging::Writer.(message, address)
      end
    end

    def pause
      broadcast Message::Pause.new
    end

    def resume
      broadcast Message::Resume.new
    end

    def stop
      broadcast Message::Stop.new
    end

    def start &supplementary_action
      loop do
        supplementary_action.() if supplementary_action

        actors.delete_if do |actor|
          thread = actor.thread
          thread.join 0
        end

        break if actors.empty?

        Thread.pass
      end

    rescue => error
      exception_notifier.(error)
      raise error
    end

    def exception_notifier
      @exception_notifier ||= proc { }
    end

    Actor = Struct.new :address, :thread

    module Assertions
      def actor? actor_address
        actors.any? do |actor|
          actor.address == actor_address
        end
      end
    end
  end
end
