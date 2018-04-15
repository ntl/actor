module TestBench
  module Controls
    module Path
      def self.example filename=nil
        filename ||= 'file.rb'

        "path/to/#{filename}"
      end
    end
  end
end
