ACTOR_THREAD_BLOCK = Proc.new { |actor_class, supervisor_queue, queue, block, args, kwargs|
  puts [
    actor_class,
    supervisor_queue,
    queue,
    block,
    args,
    kwargs
  ].inspect

  send = Messaging::Send.new
  send.(Messages::Start, queue)
  puts "Sent Start"

  actor_class = actor_class.split('::').reduce(Object) do |mod, const|
    mod.const_get(const)
  end
  puts "Resolved actor class #{actor_class}"

  actor = Build.(actor_class, *args, queue: queue, **kwargs, &block)
  puts "Started actor"

  actor_started = Messages::ActorStarted.new(queue, actor)
  send.(actor_started, supervisor_queue)
  puts "Sent ActorStarted"

  begin
    puts "Starting run loop"
    actor.run_loop

    puts "Actor stopped"
    actor_stopped = Messages::ActorStopped.new(queue, actor)
    send.(actor_stopped, supervisor_queue)

  rescue => error
    puts "Actor crashed"
    actor_crashed = Messages::ActorCrashed.new(error, actor)
    send.(actor_crashed, supervisor_queue)
  end
}

module Actor
  class Start
    def self.call(actor_class, queue, *args, **kwargs, &block)
      queue ||= Messaging::Queue.get

      supervisor_queue = Supervisor::Queue::Get.()

      actor_class = actor_class.name

      thread = Thread.new(actor_class, supervisor_queue, queue, block, args, kwargs, &ACTOR_THREAD_BLOCK)

      thread
    end
  end
end
