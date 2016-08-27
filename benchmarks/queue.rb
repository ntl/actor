require_relative './benchmark_init'

Benchmark.ips do |bm|
  object = Object.new

  bm.report 'stdlib-queue' do |iterations|
    queue = Queue.new

    iterations.times do
      queue.enq object
      queue.deq
    end
  end

  bm.report 'actor-queue' do |iterations|
    actor_queue = Actor::Queue.new
    actor_queue.consumer_started

    iterations.times do |position| 
      actor_queue.write object
      actor_queue.read position, wait: true
    end
  end

  bm.compare!
end
