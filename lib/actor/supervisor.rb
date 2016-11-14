module Actor
  class Supervisor
    include Module::Dependencies
    include Module::Handler
    include Module::RunLoop

    include Messaging::Publisher::Dependency

    attr_accessor :actor_count
    attr_writer :assembly_block
    attr_accessor :error
    attr_writer :thread_group

    def initialize
      @actor_count = 0
    end

    def self.build &assembly_block
      instance = new
      instance.assembly_block = assembly_block
      instance.configure
      instance
    end

    def self.start &assembly_block
      thread_group = Thread.current.group

      prior_thread_count = thread_group.list.count

      instance = build &assembly_block

      thread_count = thread_group.list.count

      unless thread_count > prior_thread_count
        raise NoActorsStarted, "Assembly block must start at least one actor"
      end

      instance.run_loop
    end

    def configure
      self.thread_group = Thread.current.group

      Address::Put.(address)

      assembly_block.(self)
    end

    handle Messages::ActorStarted do |message|
      publisher.register message.address

      self.actor_count += 1
    end

    handle Messages::ActorStopped do |message|
      publisher.unregister message.address

      self.actor_count -= 1

      if actor_count.zero?
        Messages::Stop
      end
    end

    handle Messages::ActorCrashed do |message|
      self.error ||= message.error

      Messages::Shutdown
    end

    handle Messages::Shutdown do
      publisher.publish Messages::Stop
    end

    handle Messages::Suspend do |message|
      publisher.publish message
    end

    handle Messages::Resume do |message|
      publisher.publish message
    end

    def assembly_block
      @assembly_block ||= proc { }
    end

    def thread_group
      @thread_group ||= ThreadGroup::Default
    end

    NoActorsStarted = Class.new StandardError
  end
end
