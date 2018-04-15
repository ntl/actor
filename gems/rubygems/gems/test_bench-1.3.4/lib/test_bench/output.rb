module TestBench
  class Output
    attr_writer :file_result
    attr_writer :reverse_backtraces
    attr_writer :run_result
    attr_writer :writer

    def initialize
      @file_result = nil
    end

    def self.build level=nil
      writer = Writer.build $stdout
      writer.level = level if level

      instance = new
      instance.writer = writer
      instance
    end

    def asserted
      file_result.asserted
      run_result.asserted
    end

    def commented prose
      writer.normal prose, :fg => :normal
    end

    def context_entered prose=nil
      return if prose.nil?

      writer.normal prose, :fg => :green

      writer.increase_indentation unless writer.level == :quiet
    end

    def context_exited prose=nil
      return if prose.nil?

      writer.decrease_indentation unless writer.level == :quiet

      writer.normal ' ' if writer.indentation.zero?
    end

    def device
      @device ||= StringIO.new
    end

    def error_raised error
      run_result.error_raised error
      file_result.error_raised error

      detail_summary = "#{error.backtrace[0]}: #{error.message} (#{error.class})"

      lines = [detail_summary]
      error.backtrace[1..-1].each do |frame|
        lines << "        from #{frame}"
      end

      lines.reverse! if reverse_backtraces

      lines.each do |line|
        writer.quiet line, :fg => :red
      end
    end

    def file_finished path
      run_result.file_finished path
      file_result.finished

      summary = summarize_result file_result

      self.file_result = nil

      writer.verbose "Finished running #{path}"
      writer.verbose summary
      writer.verbose ' '
    end

    def file_result
      @file_result or Result::Null
    end

    def file_started path
      writer.normal "Running #{path}"

      file_result = Result.build

      self.file_result = file_result

      file_result
    end

    def reverse_backtraces
      ivar = :@reverse_backtraces

      if instance_variable_defined? ivar
        instance_variable_get ivar
      else
        instance_variable_set ivar, false
      end
    end

    def run_finished
      run_result.run_finished

      files_label = if run_result.files.size == 1 then 'file' else 'files' end

      color = if run_result.passed? then :cyan else :red end

      writer.quiet "Finished running #{run_result.files.size} #{files_label}"

      summary = summarize_result run_result

      writer.quiet summary, :fg => color
    end

    def run_started
      self.run_result
    end

    def run_result
      @run_result ||= Result.build
    end

    def summarize_result result
      minutes, seconds = result.elapsed_time.divmod 60

      elapsed = String.new
      elapsed << "#{minutes}m" unless minutes.zero?
      elapsed << "%.3fs" % seconds

      test_label = if result.tests == 1 then 'test' else 'tests' end
      error_label = if result.errors == 1 then 'error' else 'errors' end
      "Ran %d #{test_label} in #{elapsed} (%.3fs tests/second)\n%d passed, %d skipped, %d failed, %d total #{error_label}" %
        [result.tests, result.tests_per_second, result.passes, result.skips, result.failures, result.errors]
    end

    def test_failed prose
      file_result.test_failed prose
      run_result.test_failed prose

      writer.quiet prose, :fg => :white, :bg => :red
    end

    def test_passed prose
      file_result.test_passed prose
      run_result.test_passed prose

      writer.normal prose, :fg => :green
    end

    def test_skipped prose
      file_result.test_skipped prose
      run_result.test_skipped prose

      writer.normal prose, :fg => :brown
    end

    def test_started prose
      writer.verbose "Started test #{prose.inspect}", :fg => :gray
    end

    def writer
      @writer ||= Writer.new
    end
  end
end
