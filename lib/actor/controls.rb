module Actor
  module Controls
    def next_message= message
      reader.message = message
    end
  end
end
