module Actor
  module Module
    module Start
      def start address: nil, supervisor_address: nil, include: nil
        address ||= Address.build

        instance = build address

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
