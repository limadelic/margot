class HashSpy
  def to_s
    @key
  end

  def [](key)
    @key = key
    self
  end
end