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

  def action
    # XXX
  end

  def actor_paused?
    actor_state == State::Paused
  end

  def actor_running?
    actor_state == State::Running
  end

  def actor_statistics
    @actor_statistics ||= Statistics.new
  end

  def handle _
    # XXX
  end

  def publish_telemetry event, argument=nil
    changed
    notify_observers event, argument
  end

  def start reader
    loop do
      begin
        message = reader.read wait: actor_paused?

        handle message if message
      end until message.nil?

      action if actor_running?

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
