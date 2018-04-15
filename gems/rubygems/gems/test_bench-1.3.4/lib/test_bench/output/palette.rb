module TestBench
  class Output
    module Palette
      def self.apply prose, **colors
        escape_code = self.escape_code(**colors)

        if escape_code.empty?
          prose
        else
          "#{escape_code}#{prose}\e[0m"
        end
      end

      def self.escape_code fg: nil, bg: nil
        return '' if fg.nil? and bg.nil?

        brightness, fg = get fg if fg
        _, bg = get bg if bg

        str = String.new "\e["

        str << "#{brightness};3#{fg}" if fg
        str << ';' if fg and bg
        str << "4#{bg}" if bg
        str << 'm'

        str
      end

      def self.get name
        code = names.index name
        return unless code
        brightness, code = code.divmod 8
        return brightness, code
      end

      def self.names
        @names ||= %i(
          black
          red
          green
          brown
          blue
          magenta
          cyan
          gray
          dark_gray
          bright_red
          bright_green
          yellow
          bright_blue
          bright_magenta
          bright_cyan
          white
        )
      end
    end
  end
end
