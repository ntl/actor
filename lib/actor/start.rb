module Actor
  class Start
    attr_writer :thread
    attr_writer :writer

    def self.build
      instance = new
      instance.thread = Thread
      Messaging::Write.configure instance
      instance
    end

    def call actor, address, include: nil
      start_message = Messages::Start.new

      writer.(start_message, address)

      thread = self.thread.new do
        actor.start
      end

      thread
    end

    def thread
      @thread ||= Substitutes::Thread
    end

    def writer
      @writer ||= Messaging::Write::Substitute.new
    end
  end
end
