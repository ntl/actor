module TestBench
  module Controls
    class DirSubstitute
      def self.example
        files = %w(
            /root/some/path/1.rb
            /root/some/path/2.rb
            /root/other/path.rb
        )

        new files
      end

      attr_reader :files

      def initialize files
        @files = files
      end

      def [] pattern
        if match_data = %r{\A(?<base>.*)/\*\*/\*\.rb\z}.match(pattern)
          # some/path/**/*.rb
          files.select do |file|
            file.start_with? match_data['base']
          end
        elsif match_data = %r{\A(?<base>.*)/\*\.rb\z}.match(pattern)
          # some/path/*.rb
          files.select do |file|
            dirname = File.dirname file
            dirname == match_data['base']
          end
        else
          # some/path.rb
          files.select do |file|
            file == pattern
          end
        end
      end

      def directories
        files.flat_map do |file|
          dirs = []

          until file == '/'
            file = File.dirname file
            dirs << file
          end

          dirs
        end
      end

      def exist? directory
        directories.include? directory.to_s
      end
    end
  end
end
