module Actor
  module Destructure
    def destructure actor, address, thread, include: nil
      return address if include.nil?

      result = [address]

      include.each do |variable_name|
        value = binding.local_variable_get variable_name

        result << value
      end

      return *result
    end
  end
end
