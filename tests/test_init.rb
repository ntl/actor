require_relative '../init'

require 'actor/controls'
require 'actor/test_fixtures'

require 'test_bench/activate'

if defined? Queue
  Object.send :const_set, :RbQueue, Queue
  Object.send :remove_const, :Queue
end

include Actor

$stdout.sync = true
