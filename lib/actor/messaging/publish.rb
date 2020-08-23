module Actor
  module Messaging
    class Publish
      include Send::Dependency

      attr_reader :queuees

      def initialize
        @queuees = Set.new
      end

      def self.build *queuees
        instance = new

        queuees.each do |queue|
          instance.register queue
        end

        instance.send = Send.new

        instance
      end

      def register queue
        queuees << queue
      end

      def unregister queue
        queuees.delete queue
      end

      def call message, wait: nil
        queuees.each do |queue|
          send.(message, queue, wait: wait)
        end
      end

      def registered? queue
        queuees.include? queue
      end
    end
  end
end
