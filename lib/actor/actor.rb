module Actor
  def self.included cls
    cls.class_exec do
      extend Destructure
      extend SpawnThread

      prepend Action
      prepend Handle
    end
  end

  attr_accessor :actor_address
  attr_accessor :actor_state
  attr_writer :reader

  def action
  end

  def actor_statistics
    @actor_statistics ||= Statistics.new
  end

  def handle _
  end

  def reader
    @reader ||= Reader::Substitute.new
  end

  def start
    loop do
      begin
        message = reader.read wait: actor_state == State::Paused

        handle message if message
      end until message.nil?

      action if actor_state == State::Running

      Thread.pass
    end
  end

  module Action
    def action
      actor_statistics.executing_action

      result = super

      actor_statistics.action_executed

      result
    end
  end

  module State
    Paused = :paused
    Running = :running
    Stopped = :stopped
  end
end
