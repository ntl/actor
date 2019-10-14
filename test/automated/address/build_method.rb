require_relative '../../test_init'

context "Address, Build Method" do
  address = Messaging::Address.build

  test "ID is configured with a UUIDv4" do
    pattern = %r{\A
      [a-f0-9]{8}          # abcdef01
      -                    #         -
      [a-f0-9]{4}          #          abcd
      -                    #              -
      4[a-f0-9]{3}         #               4abc
      -                    #                   -
      [89ab][a-f0-9]{3}    #                    8abc
      -                    #                        -
      [a-f0-9]{12}         #                         abcdef012345
    \Z}xi

    assert pattern.match?(address.id)
  end

  test "Queue is configured with a SizedQueue" do
    assert address.queue.instance_of?(SizedQueue)

    assert address.queue.max == Messaging::Queue::Defaults.maximum_size
  end
end
