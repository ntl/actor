module Actor
  class Supervisor
    include Module
    include Messaging::Publisher::Dependency

    attr_accessor :assembly_block
    attr_accessor :error
    attr_writer :thread_group

    def self.build &assembly_block
      instance = new
      instance.assembly_block = assembly_block if assembly_block
      instance
    end

    def configure
      self.thread_group = Thread.current.group

      assembly_block.(address) if assembly_block
    end

    handle Messages::ActorStarted do |message|
      publisher.register message.address
    end

    handle Messages::ActorStopped do |message|
      publisher.unregister message.address
    end

    handle Messages::ActorCrashed do |message|
      self.error ||= message.error

      Messages::Shutdown.new
    end

    def thread_group
      @thread_group ||= ThreadGroup::Default
    end
  end
end
