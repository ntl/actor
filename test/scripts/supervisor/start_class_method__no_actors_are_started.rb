require_relative '../../test_init'

context "Supervisor Start Class Method, No Actors are Started by Assembly" do
  assembly_block = proc { }

  test "Error is raised indicating no actors were started" do
    assert proc { Supervisor.start &assembly_block } do
      raises_error? Supervisor::NoActorsStarted
    end
  end
end
