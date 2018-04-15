module TestBench
  class Output
    module Assertions
      def color_output?
        text = 'Some Text'
        color = :gray

        write text, :fg => color, :bg => color

        wrote_line? text, :fg => color, :bg => color
      end

      def text_written
        device.rewind
        device.read
      end

      def wrote? text
        text_written == text
      end

      def wrote_line? text, indent: nil, **colors
        color ||= {}
        indent ||= 0

        color_escape = Palette.escape_code(**colors)
        unless color_escape.empty?
          text = "#{color_escape}#{text}\e[0m"
        end

        matcher = Regexp.escape "#{'  ' * indent}#{text}"

        pattern = /^#{matcher}$/n

        pattern.match text_written
      end

      def wrote_nothing?
        text_written.empty?
      end
    end
  end
end
