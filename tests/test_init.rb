require 'pp'

require_relative '../init'

require 'test_bench/activate'

require 'actor/controls'

include Actor

module Stress
  def self.times &block
    iterations.times &block
  end

  def self.iterations
    str = ENV.fetch 'STRESS_ITERATIONS' do '1' end
    str.to_i
  end
end
