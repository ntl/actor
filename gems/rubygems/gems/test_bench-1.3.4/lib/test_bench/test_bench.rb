module TestBench
  def self.activate
    # Monkeypatch assert, context, and test onto the main object
    unless TOPLEVEL_BINDING.receiver.is_a? Structure
      TOPLEVEL_BINDING.receiver.extend Structure
    end

    # Ruby pre 2.2 did not implement Binding#receiver
    unless TOPLEVEL_BINDING.respond_to? :receiver
      ::Binding.class_exec do
        def receiver
          eval "self"
        end
      end
    end
  end

  # Build the output instance that will be used to render all the test output
  output = Output.build

  # Settings can affect the output (verbosity & color), so we pass the output
  # object into the toplevel settings object and then apply environment
  # variables to it.
  settings = Settings::Registry.get TOPLEVEL_BINDING
  settings.writer = output.writer
  Settings::Environment.(settings)

  # Configure reverse backtraces on output
  output.reverse_backtraces = settings.reverse_backtraces

  # Telemetry pushes updates to output for display
  Telemetry.subscribe output
end
