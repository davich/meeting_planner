require 'slot'

class SlotPlanner
  def initialize(slot_a, slot_b, duration)
    @slot_a = Slot.new(slot_a)
    @slot_b = Slot.new(slot_b)
    @duration = duration
  end

  def plan
    return { increment_index_a: true } if slot_b_starts_after_slot_a_ends?
    return { increment_index_b: true } if slot_a_starts_after_slot_b_ends?
    return { slot_found: first_overlap_of_duration } if large_enough_overlap?

    if slot_a_ends_first?
      { increment_index_a: true }
    else
      { increment_index_b: true }
    end
  end

  private

  attr_reader :duration, :slot_a, :slot_b

  def slot_a_starts_after_slot_b_ends?
    slot_a.start > slot_b.end
  end

  def slot_b_starts_after_slot_a_ends?
    slot_b.start > slot_a.end
  end

  def large_enough_overlap?
    overlap_size >= duration
  end

  def first_overlap_of_duration
    [largest_start_time, largest_start_time + duration]
  end

  def slot_a_ends_first?
    slot_a.end < slot_b.end
  end

  def overlap_size
    smallest_end_time - largest_start_time
  end

  def largest_start_time
    [slot_a.start, slot_b.start].max
  end

  def smallest_end_time
    [slot_a.end, slot_b.end].min
  end
end
