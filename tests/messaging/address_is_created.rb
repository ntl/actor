require_relative '../test_init'

context "Address is created" do
  address = Messaging::Address.get

  address.queue.tail = 11
  address.queue.list << Object.new

  address.queue.reader_started
  address.queue.reader_started
  address.queue.reader_started

  test "UUID v4 is assigned to address" do
    uuid_v4_pattern = %r{
      [a-f0-9]{8}          # abcdef01
      -                    #         -
      [a-f0-9]{4}          #          abcd
      -                    #              -
      4[a-f0-9]{3}         #               4abc
      -                    #                   -
      [89ab][a-f0-9]{3}    #                    8abc
      -                    #                        -
      [a-f0-9]{12}         #                         abcdef012345
    }xi

    assert uuid_v4_pattern.match address.id
  end

  test "Queue is assigned to address" do
    assert address.queue.instance_of? Queue
  end

  test "Queue position details can be queried" do
    assert address.queue_tail == 11
    assert address.queue_head == 12
  end

  test "Queue size can be queried" do
    assert address.queue_size == 1
  end

  test "Number of readers can be queried" do
    assert address.reader_count == 3
  end

  test "Inspect method" do
    assert address.inspect == %{#<Actor::Messaging::Address id=#{address.id.inspect}, queue=11..12, readers=3>}
  end
end
