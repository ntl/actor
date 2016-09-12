module Actor
  module Destructure
    def self.call primary_return_value, include=nil, **values
      include = Array(include)

      if include.empty?
        primary_return_value
      else
        return_values = include.map do |return_value_name|
          begin
            values.fetch return_value_name
          rescue KeyError
            raise Error, "Invalid return value to include `#{return_value_name.inspect}'"
          end
        end

        return primary_return_value, *return_values
      end
    end

    Error = Class.new StandardError
  end
end
