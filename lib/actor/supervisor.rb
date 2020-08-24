ACTOR_START_SUPERVISOR_THREAD = Proc.new { |assembly_block|
  supervisor_cls = Object.const_get(:Actor).const_get(:Supervisor)

  instance = Actor::Build.(supervisor_cls, &assembly_block)
  instance.run_loop
}

module Actor
  class Supervisor
    include Module::Dependencies
    include Module::Handler
    include Module::RunLoop

    include Messaging::Publish::Dependency

    attr_accessor :actor_count
    attr_writer :assembly_block
    attr_accessor :error

    def initialize
      @actor_count = 0
    end

    def self.build &assembly_block
      instance = new
      instance.assembly_block = assembly_block
      instance
    end

    def self.start &assembly_block
      thread = Thread.new(assembly_block, &ACTOR_START_SUPERVISOR_THREAD)

      loop do
        if RUBY_ENGINE == 'mruby'
          result = thread.join
        else
          ten_seconds = 10

          result = thread.join(ten_seconds)
        end

        break unless result.nil?
      end
    end

    def configure
      Queue::Put.(queue)

      assembly_block.(self)

      self.publish = Messaging::Publish.build
    end

    def handle message
      result = super

      changed
      notify_observers message

      result
    end

    def changed
    end

    def notify_observers(message)
      observers.each do |observer|
        observer.handle(message)
      end
    end

    def add_observer(observer)
      observers << observer
    end

    def observers
      @observers ||= []
    end

    handle Messages::ActorStarted do |message|
      publish.register message.queue

      self.actor_count += 1
    end

    handle Messages::ActorStopped do |message|
      publish.unregister message.queue

      self.actor_count -= 1

      if actor_count.zero?
        send.(Messages::Stop, queue)
      end
    end

    handle Messages::ActorCrashed do |message|
      self.error ||= message.error

      self.actor_count -= 1

      if actor_count.zero?
        send.(Messages::Stop, queue)
      else
        send.(Messages::Shutdown, queue)
      end
    end

    handle Messages::Shutdown do
      publish.(Messages::Stop)
    end

    handle Messages::Suspend do |message|
      publish.(message)
    end

    handle Messages::Resume do |message|
      publish.(message)
    end

    handle Messages::Stop do |stop|
      raise error if error

      super stop
    end

    def registered_actor? actor
      publish.registered? actor.queue
    end

    def unregistered_actor? actor
      publish.unregistered? actor.queue
    end

    def assembly_block
      @assembly_block ||= proc { }
    end

    NoActorsStarted = Class.new StandardError
  end
end
