require 'pp'

require_relative '../init'

require 'actor/controls'

require 'test_bench/activate'

Thread.abort_on_exception = false
Thread.report_on_exception = false

Controls = Actor::Controls
