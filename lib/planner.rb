require 'slot_planner'

class Planner
  def initialize(slots_a, slots_b, dur)
    @slots_a = slots_a
    @slots_b = slots_b
    @dur = dur
  end

  def meeting_planner
    index_a = 0
    index_b = 0
    while index_a < slots_a.size && index_b < slots_b.size
      result = SlotPlanner.new(slots_a[index_a], slots_b[index_b], dur).plan

      return result[:slot_found] if result[:slot_found]
      index_a += 1 if result[:increment_index_a]
      index_b += 1 if result[:increment_index_b]
    end
  end

  private

  attr_reader :slots_a, :slots_b, :dur
end

