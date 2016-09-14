module Actor
  class Start
    attr_writer :supervisor_address
    attr_writer :thread_class
    attr_writer :writer

    def self.build supervisor_address: nil
      supervisor_address ||= Supervisor.address

      instance = new
      instance.supervisor_address = supervisor_address
      instance.thread_class = Thread
      Messaging::Write.configure instance
      instance
    end

    def self.call actor, address, supervisor_address: nil
      instance = build supervisor_address: supervisor_address
      instance.(actor, address)
    end

    def call actor, address
      address ||= Address.build

      start = Messages::Start.new
      writer.(start, address)

      actor_started = Messages::ActorStarted.new address
      writer.(actor_started, supervisor_address)

      actor.address = address

      thread = thread_class.new do
        actor.configure
        actor.start
      end

      thread.name = actor.class.name

      thread
    end

    def supervisor_address
      @supervisor_address ||= Address::None
    end

    def thread_class
      @thread_class ||= Substitutes::Thread
    end

    def writer
      @writer ||= Messaging::Write::Substitute.new
    end
  end
end
