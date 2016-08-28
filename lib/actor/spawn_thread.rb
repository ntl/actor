module Actor
  module SpawnThread
    def spawn_thread *positional_arguments, include: nil, **keyword_arguments, &block
      address = Messaging::Address.get

      if keyword_arguments.empty?
        instance = new *positional_arguments, &block
      else
        instance = new *positional_arguments, **keyword_arguments, &block
      end

      reader = Messaging::Reader.build address

      instance.actor_address = address
      instance.actor_state = State::Paused
      instance.reader = reader

      thread = ::Thread.new do
        instance.run_loop
      end

      destructure instance, address, thread, include: include
    end
    alias_method :start, :spawn_thread
  end
end
