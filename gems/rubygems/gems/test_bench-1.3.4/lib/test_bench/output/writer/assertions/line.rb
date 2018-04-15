module TestBench
  class Output
    class Writer
      module Assertions
        class Line
          IgnoreParameter = Object.new

          attr_reader :match

          def initialize match
            @match = match
          end

          def self.parse line
            match = Pattern.match line
            new match
          end

          def call expected_prose, bg: IgnoreParameter, fg: IgnoreParameter, indentation: IgnoreParameter
            return unless match

            return unless prose? expected_prose
            return unless foreground_color? fg unless fg == IgnoreParameter
            return unless background_color? bg unless bg == IgnoreParameter
            return unless indentation? indentation unless indentation == IgnoreParameter

            true
          end

          def background_color? bg
            if bg.nil?
              match['bg'].nil?
            else
              _, code = Palette.get bg
              match['bg'].to_i == code + 40
            end
          end

          def foreground_color? fg
            if fg.nil?
              match['fg'].nil? and match['brightness'].nil?
            else
              brightness, code = Palette.get fg
              match['fg'].to_i == code + 30 and
                match['brightness'].to_i == brightness
            end
          end

          def indentation? indentation
            match['indentation'].to_s == '  ' * indentation
          end

          def prose? expected_prose
            match['prose'] == expected_prose
          end

          Pattern = %r{
            \A
              (?<indentation>[[:space:]]{2})*
              (?<color>
                \e\[
                (?:(?<brightness>[01])|(?<fg>3[0-7])|(?<bg>4[0-7]))
                (?:
                  ;(?:(?<brightness>[01])|(?<fg>3[0-7])|(?<bg>4[0-7]))
                ){0,2}
                m
              )?
              (?<prose>[^\e\n]+)
              (?:\e\[0m)?
            \Z
          }x
        end
      end
    end
  end
end
