module Actor
  module Module
    module Start
      def start *arguments, include: nil, **keyword_arguments, &block
        arguments << keyword_arguments if keyword_arguments.any?

        actor, thread = Actor::Start.(self, *arguments, &block)

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
