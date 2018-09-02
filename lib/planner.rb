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

  def meeting_planner2
    result = [0, 0]
    begin
      continue, result = _meeting_planner(*result)
    end while continue == true
    result
  end

  def _meeting_planner2(index_a, index_b)
    return [false, nil] unless index_a < slots_a.size && index_b < slots_b.size

    result = SlotPlanner.new(slots_a[index_a], slots_b[index_b], dur).plan

    return [false, result[:slot_found]] if result[:slot_found]

    index_a += 1 if result[:increment_index_a]
    index_b += 1 if result[:increment_index_b]

    [true, [index_a, index_b]]
  end

  def meeting_planner3
    _meeting_planner(0, 0)
  end

  def _meeting_planner3(index_a, index_b)
    return nil unless index_a < slots_a.size && index_b < slots_b.size

    result = SlotPlanner.new(slots_a[index_a], slots_b[index_b], dur).plan

    return result[:slot_found] if result[:slot_found]

    index_a += 1 if result[:increment_index_a]
    index_b += 1 if result[:increment_index_b]

    _meeting_planner(index_a, index_b)
  end

  private

  attr_reader :slots_a, :slots_b, :dur
end

