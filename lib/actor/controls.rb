module Actor
  module Controls
    def next_message= message
      reader.add message
    end
  end
end
