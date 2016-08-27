# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'test_bench'
  s.version = '1.1.1'

  s.authors = ['Nathan Ladd']
  s.homepage = 'https://github.com/ntl/test-bench'
  s.email = 'nathanladd+github@gmail.com'
  s.licenses = %w(MIT)
  s.summary = "A frugal test framework for ruby"
  s.description = "Test Bench is a test framework for ruby designed to offer the minimum set of features necessary to test well designed code effectively."

  s.executables = ['bench']
  s.bindir = 'bin'

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'
  s.platform = Gem::Platform::RUBY
end
