module Actor
  # It is possible to `include Actor' in the top-level namespace in order to
  # bring this library's constants into focus (i.e. reference them without any
  # leading `Actor' reference to qualify them). The test suite does this; see
  # tests/test_init.rb. In that case, we take care not to attach any Actor
  # behavior onto Object. This is achieved by placing the implementation of
  # Actor in Actor::Module
  def self.included cls
    cls.include Module unless cls == Object
  end
end
