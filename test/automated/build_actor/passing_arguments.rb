require_relative '../../test_init'

context "Build Actor, Passing Arguments" do
  context "Initializer includes only positional or block arguments" do
    actor_cls = Controls::Actor.define do
      attr_reader :positional, :block

      def initialize positional, &block
        block ||= :no_block
        @positional, @block = positional, block
      end
    end

    actor = Actor::Build.(actor_cls, 'positional') do
      :block_invoked
    end

    test "Positional argument is passed to constructor" do
      assert actor.positional == 'positional'
    end

    test "Block is passed to constructor" do
      assert actor.block.() == :block_invoked
    end
  end

  context "Initializer includes keyword arguments" do
    actor_cls = Controls::Actor.define do
      attr_reader :positional, :keyword

      def initialize positional, keyword: nil
        @positional, @keyword = positional, keyword
      end
    end

    actor = Actor::Build.(actor_cls,'positional', keyword: 'keyword')

    test "Positional argument is passed to constructor" do
      assert actor.positional == 'positional'
    end

    test "Keyword argument is passed to constructor" do
      assert actor.keyword == 'keyword'
    end
  end
end
