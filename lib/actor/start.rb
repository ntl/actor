module Actor
  class Start
    attr_writer :supervisor_address
    attr_writer :thread
    attr_writer :writer

    def self.build supervisor_address: nil
      instance = new
      instance.supervisor_address = supervisor_address
      instance.thread = Thread
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

      self.thread.new do
        actor.start
      end
    end

    def supervisor_address
      @supervisor_address ||= Address::None
    end

    def thread
      @thread ||= Substitutes::Thread
    end

    def writer
      @writer ||= Messaging::Write::Substitute.new
    end
  end
end
