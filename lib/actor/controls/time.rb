module Actor
  module Controls
    module Time
      def self.example offset=nil
        offset ||= 0
        offset = ElapsedTime.example offset

        reference + offset
      end

      def self.reference
        ::Time.new 2000, 1, 1, 11, 11, 11, -3600
      end

      module ElapsedTime
        def self.example scalar=nil
          scalar ||= 1

          Rational(scalar, 1000)
        end
      end
    end
  end
end
