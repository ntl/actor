require_relative '../../test_init'

context "Actor is Started Via Class Method, Passing Arguments to Actor" do
  context "Initializer includes only positional or block arguments" do
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :positional, :block

      def initialize positional, &block
        block ||= :no_block
        @positional, @block = positional, block
      end

      handle :start do
        :stop
      end
    end

    _, actor = actor_cls.start 'positional', include: :actor do
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
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :positional, :keyword

      def initialize positional, keyword: nil
        @positional, @keyword = positional, keyword
      end

      handle :start do
        :stop
      end
    end

    _, actor = actor_cls.start 'positional', keyword: 'keyword', include: :actor

    test "Positional argument is passed to constructor" do
      assert actor.positional == 'positional'
    end

    test "Keyword argument is passed to constructor" do
      assert actor.keyword == 'keyword'
    end
  end
end
