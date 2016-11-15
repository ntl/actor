module Actor
  module Controls
    def next_message= message
      read.add message
    end
  end
end
