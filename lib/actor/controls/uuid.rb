module Actor
  module Controls
    module UUID
      def self.example id_offset=nil
        id_offset ||= 0

        id_offset = id_offset.to_s 16

        dword = id_offset.rjust 8, '0'

        "#{dword}-0000-4000-8000-000000000000"
      end
    end
  end
end
