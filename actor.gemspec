# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'ntl-actor'
  s.version = '1.4.2'

  s.authors = ['Nathan Ladd']
  s.homepage = 'https://github.com/ntl/actor'
  s.email = 'nathanladd+github@gmail.com'
  s.licenses = %w(MIT)
  s.summary = "Implementation of actor pattern for Ruby"
  s.description = "Implementation of actor pattern for Ruby"

  s.require_paths = %w(lib src)
  s.files = Dir.glob 'lib/**/*'
  s.platform = Gem::Platform::RUBY

  s.add_runtime_dependency 'observer'

  s.add_development_dependency 'test_bench'
end
