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

class SlotPlanner
  def initialize(slot_a, slot_b, dur)
    @slot_a = slot_a
    @slot_b = slot_b
    @dur = dur
  end

  def plan
    if slot_b_starts_after_slot_a_ends?
      { increment_index_a: true }
    elsif slot_a_starts_after_slot_b_ends?
      { increment_index_b: true }
    else
      if large_enough_overlap?
        { slot_found: first_overlap_of_dur }
      else
        if slot_a_ends_first?
          { increment_index_a: true }
        else
          { increment_index_b: true }
        end
      end
    end
  end

  private

  attr_reader :dur, :slot_a, :slot_b

  def slot_a_ends_first?
    slot_a_end < slot_b_end
  end

  def first_overlap_of_dur
    [largest_start_time, largest_start_time + dur]
  end

  def slot_b_starts_after_slot_a_ends?
    slot_b_start > slot_a_end
  end

  def slot_a_starts_after_slot_b_ends?
    slot_a_start > slot_b_end
  end

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
