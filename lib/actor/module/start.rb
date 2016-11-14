module Actor
  module Module
    module Start
      def start *arguments, &block
        actor, _ = Actor::Start.(self, *arguments, &block)

        address = actor.address

        return address
      end
    end
  end
end
