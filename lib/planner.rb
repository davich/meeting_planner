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
      #if the start time of slot A is greater than the end time of slot B, then increment the index of slot B
      if slot_a_start(index_a) > slot_b_end(index_b)
        index_b += 1
      # elsif the start time of slot B is greater the end time of slot A, increment the index of A
      elsif slot_b_start(index_b) > slot_a_end(index_a)
        index_a += 1
      else
        # overlap = the smallest end time - the largest start time
        if overlap_size(index_a, index_b) >= dur
          largest_start = largest_start_time(index_a, index_b)
          return [largest_start, largest_start + dur]
        else
          # move on the the next index in the slot with the smallest end time
          if slot_a_end(index_a) < slot_b_end(index_b)
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

  def slot_a_start(index_a)
    slots_a[index_a][0]
  end

  def slot_a_end(index_a)
    slots_a[index_a][1]
  end

  def slot_b_start(index_b)
    slots_b[index_b][0]
  end

  def slot_b_end(index_b)
    slots_b[index_b][1]
  end

  def overlap_size(index_a, index_b)
    smallest_end_time(index_a, index_b) - largest_start_time(index_a, index_b)
  end

  def largest_start_time(index_a, index_b)
    [slots_a[index_a][0], slots_b[index_b][0]].max
  end

  def smallest_end_time(index_a, index_b)
    [slots_a[index_a][1], slots_b[index_b][1]].min
  end
end
