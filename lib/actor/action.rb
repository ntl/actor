module Actor
  module Action
    def self.included cls
      cls.class_exec do
        prepend UpdateStatistics
      end
    end

    def action
    end

    module UpdateStatistics
      def action
        actor_statistics.executing_action

        result = super

        actor_statistics.action_executed

        result
      end
    end
  end
end
