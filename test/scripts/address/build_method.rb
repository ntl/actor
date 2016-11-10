require_relative '../../test_init'

context "Address, Build Method" do
  address = Messaging::Address.build

  test "ID is configured with a UUIDv4" do
    assert address.id do |uuid|
      %r{\A
        [a-f0-9]{8}          # abcdef01
        -                    #         -
        [a-f0-9]{4}          #          abcd
        -                    #              -
        4[a-f0-9]{3}         #               4abc
        -                    #                   -
        [89ab][a-f0-9]{3}    #                    8abc
        -                    #                        -
        [a-f0-9]{12}         #                         abcdef012345
      \Z}xi.match uuid
    end
  end

  test "Queue is configured with a SizedQueue" do
    assert address.queue do
      instance_of? SizedQueue
    end

    assert address.queue do
      max == address.class::Queue::Defaults.maximum_size
    end
  end
end
