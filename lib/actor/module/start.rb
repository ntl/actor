module Actor
  module Module
    module Start
      def start *positional_arguments, address: nil, supervisor_address: nil, include: nil, **keyword_arguments, &block
        address ||= Address.build

        instance = build address, *positional_arguments, **keyword_arguments, &block

        thread = Actor::Start.(
          instance,
          address,
          supervisor_address: supervisor_address
        )

        Destructure.(address, include, { :thread => thread, :actor => instance })
      end
    end
  end
end
