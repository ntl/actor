module Actor
  module Module
    module Start
      def start *arguments, include: nil, **keyword_arguments, &block
        actor, thread = Actor::Start.(self, *arguments, **keyword_arguments, &block)

        address = actor.address

        if include
          return_values = [address]

          Array(include).each do |label|
            argument = { :thread => thread, :actor => actor }.fetch label

            return_values << argument
          end

          return return_values
        else
          return address
        end
      end
    end
  end
end
