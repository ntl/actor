module Controls
  class SupervisorObserver
    include ::Actor::Supervisor::Observer
    include Message

    def initialize
      @messages = []
    end

    def self.build supervisor
      instance = new
      supervisor.add_observer instance
      instance
    end

    handle ActorStarted do |msg|
      @messages << msg
    end

    handle ActorCrashed do |msg|
      @messages << msg
    end

    def handled?(msg)
      @messages.include? msg
    end
  end
end
