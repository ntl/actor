require_relative '../test_init'

context "Actor is built" do
  address = Controls::Address.example

  context do
    actor = Controls::Actor::Example.build address

    test "Reader is built for specified address" do
      assert actor.reader.instance_of? Messaging::Read
      assert actor.reader.stream == address.stream
    end

    test "Writer is built" do
      assert actor.writer.instance_of? Messaging::Write
    end

    test "Address is assigned" do
      assert actor.address == address
    end
  end

  context "Actor implementation specifies configure method" do
    cls = Class.new do
      include Actor

      def configure
        @configured = true
      end

      def configured?
        @configured ? true : false
      end
    end

    actor = cls.build address

    test "Configure method is executed" do
      assert actor.configured?
    end
  end

  context "Arguments are passed to build" do
    context do
      cls = Class.new do
        include Actor

        def initialize req, opt=nil, key: nil, keyreq:, &block
          @req, @opt, @key, @keyreq, @block = req, opt, key, keyreq, block
        end

        def arguments_passed_to_initialize?
          @req == 'req' and @opt == 'opt' and @key == 'key' and @keyreq == 'keyreq' and @block.() == 'block'
        end
      end

      actor = cls.build address, 'req', 'opt', key: 'key', keyreq: 'keyreq' do 'block' end

      test "Arguments are forwarded to the initialize method" do
        assert actor.arguments_passed_to_initialize?
      end
    end

    context "No keyword arguments are included" do
      cls = Class.new do
        include Actor

        def initialize req, opt=nil, key: nil, &block
          @req, @opt, @key, @block = req, opt, key, block
        end

        def arguments_passed_to_initialize?
          @req == 'req' and @opt == 'opt' and @key.nil? and @block.() == 'block'
        end
      end

      actor = cls.build address, 'req', 'opt' do 'block' end

      test "Arguments are forwarded to the initialize method" do
        assert actor.arguments_passed_to_initialize?
      end
    end
  end
end
