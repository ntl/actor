module Actor
  module Observers
    def observe message_pattern, &callback
      handler_method = HandleMacro::MethodName.get message_pattern

      observer_id = callback.object_id

      record = Observer.new observer_id, handler_method, callback

      add_observer record
    end

    def add_observer record
      observers = observer_registry[record.handler_method]

      observers[record.observer_id] = record
    end

    def notify_observers message
      handler_method = HandleMacro::MethodName.get message

      observers = observer_registry[handler_method]

      observers.each_value.map do |record|
        callback = record.callback

        callback.(message)
      end
    end

    def remove_observer record
      observers = observer_registry[record.handler_method]

      observers.delete record.observer_id
    end

    def observer_registry
      @observer_registry ||= Hash.new do |hash, handler_method|
        hash[handler_method] = {}
      end
    end

    Observer = Struct.new :observer_id, :handler_method, :callback
  end
end
