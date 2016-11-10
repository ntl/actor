require_relative '../../test_init'

context "Supervisor Invokes Assembly Block" do
  assembly_block_invoked = false
  block_argument = nil

  supervisor = Build.(Supervisor) do |address|
    assembly_block_invoked = true
    block_argument = address
  end

  test "Assembly block is invoked" do
    assert assembly_block_invoked
  end

  test "Address of supervisor is passed to block" do
    assert block_argument == supervisor.address
  end
end
