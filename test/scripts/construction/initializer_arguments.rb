require_relative '../scripts_init'

context "Actor Builder Passes Specified Arguments to Constructor" do
  context "Initializer includes only positional arguments" do
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :req, :opt

      def initialize req, opt=:default_opt
        @req, @opt = req, opt
      end
    end

    context "Only required argument is supplied" do
      actor = Build.(actor_cls, 'req')

      test "Required positional argument is passed to constructor" do
        assert actor.req == 'req'
      end

      test "Default value is used for optional positional argument" do
        assert actor.opt == :default_opt
      end
    end

    context "Optional argument is supplied" do
      actor = Build.(actor_cls, 'req', 'opt')

      test "Required positional argument is passed to constructor" do
        assert actor.req == 'req'
      end

      test "Optional positional argument is passed to constructor" do
        assert actor.opt == 'opt'
      end
    end
  end

  context "Initializer includes only keyword arguments" do
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :keyreq, :key

      def initialize keyreq:, key: :default_key
        @keyreq, @key = keyreq, key
      end
    end

    context "Only required argument is supplied" do
      actor = Build.(actor_cls, keyreq: 'keyreq')

      test "Required keyword argument is passed to constructor" do
        assert actor.keyreq == 'keyreq'
      end

      test "Default value is used for optional keyword argument" do
        assert actor.key == :default_key
      end
    end

    context "Optional argument is supplied" do
      actor = Build.(actor_cls, keyreq: 'keyreq', key: 'key')

      test "Required keyword argument is passed to constructor" do
        assert actor.keyreq == 'keyreq'
      end

      test "Optional keyword argument is passed to constructor" do
        assert actor.key == 'key'
      end
    end
  end

  context "Initializer includes block argument" do
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :block

      def initialize &block
        block ||= :no_block
        @block = block
      end
    end

    context "Block argument is not supplied" do
      actor = Build.(actor_cls)

      test "Nothing is passed in to block argument" do
        assert actor.block == :no_block
      end
    end

    context "Block argument is supplied" do
      actor = Build.(actor_cls) do
        :block_invoked
      end

      test "Specified block is passed in to block argument" do
        assert actor.block.() == :block_invoked
      end
    end
  end

  context "Initializer includes mix of all argument types" do
    actor_cls = Fixtures::Controls::Actor.define do
      attr_reader :req, :opt, :keyreq, :key, :block

      def initialize req, opt=:default_opt, keyreq:, key: :default_key, &block
        block ||= :no_block
        @req, @opt, @keyreq, @key, @block = req, opt, keyreq, key, block
      end
    end

    context "Only required arguments are supplied" do
      actor = Actor::Build.(
        actor_cls,
        'req',
        keyreq: 'keyreq'
      )

      test "Required positional argument is passed to constructor" do
        assert actor.req == 'req'
      end

      test "Required keyword argument is passed to constructor" do
        assert actor.keyreq == 'keyreq'
      end

      test "Default values are used for optional arguments" do
        assert actor.opt == :default_opt
        assert actor.key == :default_key
        assert actor.block == :no_block
      end
    end

    context "Optional arguments are also supplied" do
      actor = Actor::Build.(
        actor_cls,
        'req',
        'opt',
        keyreq: 'keyreq',
        key: 'key'
      ) { :block_invoked }

      test "Optional positional argument is passed to constructor" do
        assert actor.opt == 'opt'
      end

      test "Optional keyword argument is passed to constructor" do
        assert actor.key == 'key'
      end

      test "Block is passed to constructor" do
        assert actor.block.() == :block_invoked
      end

      test "Required arguments are passed to constructor" do
        assert actor.req == 'req'
        assert actor.keyreq == 'keyreq'
      end
    end
  end
end
