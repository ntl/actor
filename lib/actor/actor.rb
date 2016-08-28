module Actor
  def self.included cls
    cls.class_exec do
      extend Destructure
      extend SpawnThread

      include Action
      include Handle
      include RunLoop
    end
  end

  attr_accessor :actor_address
  attr_accessor :actor_state
  attr_writer :reader

  def actor_statistics
    @actor_statistics ||= Statistics.new
  end

  def reader
    @reader ||= Reader::Substitute.new
  end

  module State
    Paused = :paused
    Running = :running
    Stopped = :stopped
  end
end
