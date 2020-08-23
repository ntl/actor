require 'pp'

require_relative '../init'

require 'test_bench'; TestBench.activate

require_relative './fixtures/fixtures_init'
require_relative './controls/controls_init'

include Actor

unless RUBY_ENGINE == 'mruby'
  Thread.abort_on_exception = true
  Thread.report_on_exception = false
end
