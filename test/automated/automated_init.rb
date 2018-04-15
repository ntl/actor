ThreadGroup::Default.enclose

require_relative '../test_init'

at_exit do
  orphaned_threads = ThreadGroup::Default.list.reject do |thread|
    thread == ::Thread.main
  end

  if orphaned_threads.any?
    fail "One or more threads were not stopped (Count: #{orphaned_threads.count})"
  end
end
