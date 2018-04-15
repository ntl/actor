module TestBench
  module Controls
    module ExpandPath
      def self.example
        -> path do
          if path == 'some/path'
            %w(some/path/1.rb some/path/2.rb)
          elsif path == 'other/path.rb'
            %w(other/path.rb)
          else
            []
          end
        end
      end

      module RootDirectory
        def self.example
          Pathname.new '/root'
        end
      end
    end
  end
end
