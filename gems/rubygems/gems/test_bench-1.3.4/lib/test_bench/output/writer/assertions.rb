module TestBench
  class Output
    class Writer
      module Assertions
        def raw_text
          device.rewind
          device.read
        end

        def wrote? expected_prose
          raw_text == expected_prose
        end

        def wrote_line? *arguments
          raw_text.each_line.any? do |line_text|
            line = Line.parse line_text
            return true if line.(*arguments)
          end

          false
        end

        def wrote_nothing?
          raw_text.empty?
        end
      end
    end
  end
end
