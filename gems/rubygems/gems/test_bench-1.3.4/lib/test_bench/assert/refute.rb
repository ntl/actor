module TestBench
  class Assert
    class Refute < Assert
      def interpret_result result
        if result then false else true end
      end
    end
  end
end
