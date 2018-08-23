class SlotPlanner
  def initialize(slot_a, slot_b, dur)
    @slot_a = slot_a
    @slot_b = slot_b
    @dur = dur
  end

  def plan
    return { increment_index_a: true } if slot_b_starts_after_slot_a_ends?
    return { increment_index_b: true } if slot_a_starts_after_slot_b_ends?
    return { slot_found: first_overlap_of_dur } if large_enough_overlap?

    if slot_a_ends_first?
      { increment_index_a: true }
    else
      { increment_index_b: true }
    end
  end

  private

  attr_reader :dur, :slot_a, :slot_b

  def slot_a_starts_after_slot_b_ends?
    slot_a_start > slot_b_end
  end

  def slot_b_starts_after_slot_a_ends?
    slot_b_start > slot_a_end
  end

  def large_enough_overlap?
    overlap_size >= dur
  end

  def first_overlap_of_dur
    [largest_start_time, largest_start_time + dur]
  end

  def slot_a_ends_first?
    slot_a_end < slot_b_end
  end

  def overlap_size
    smallest_end_time - largest_start_time
  end

  def largest_start_time
    [slot_a_start, slot_b_start].max
  end

  def smallest_end_time
    [slot_a_end, slot_b_end].min
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
end
