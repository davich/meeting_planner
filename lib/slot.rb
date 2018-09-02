class Slot
  def initialize(tuple)
    @tuple = tuple
  end

  def start
    @tuple.first
  end

  def end
    @tuple.last
  end
end
