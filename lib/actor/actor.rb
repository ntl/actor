module Actor
  def self.included cls
    unless cls == Object
      cls.include Module
    end
  end
end
