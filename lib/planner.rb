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
      slot_planner = SlotPlanner.new(slots_a[index_a], slots_b[index_b], dur)
      if slot_planner.slot_a_start > slot_planner.slot_b_end
        index_b += 1
      elsif slot_planner.slot_b_start > slot_planner.slot_a_end
        index_a += 1
      else
        if slot_planner.large_enough_overlap?
          largest_start = slot_planner.largest_start_time
          return [largest_start, largest_start + dur]
        else
          if slot_planner.slot_a_end < slot_planner.slot_b_end
            index_a += 1
          else
            index_b += 1
          end
        end
      end
    end
  end

  private

  attr_reader :slots_a, :slots_b, :dur
end

class SlotPlanner
  def initialize(slot_a, slot_b, dur)
    @slot_a = slot_a
    @slot_b = slot_b
    @dur = dur
  end

  attr_reader :dur, :slot_a, :slot_b

  def large_enough_overlap?
    overlap_size >= dur
  end

  def slot_a_start
    slot_a[0]
  end

  def slot_a_end
    slot_a[1]
  end

  def slot_b_start
    slot_b[0]
  end

  def slot_b_end
    slot_b[1]
  end

  def overlap_size
    smallest_end_time - largest_start_time
  end

  def largest_start_time
    [slot_a[0], slot_b[0]].max
  end

  def smallest_end_time
    [slot_a[1], slot_b[1]].min
  end
end
