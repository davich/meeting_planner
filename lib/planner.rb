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
      if slots_a[index_a][0] > slots_b[index_b][1]
        index_b += 1
      # elsif the start time of slot B is greater the end time of slot A, increment the index of A
      elsif slots_b[index_b][0] > slots_a[index_a][1]
        index_a += 1
      else
        # overlap = the smallest end time - the largest start time
        if overlap_size(index_a, index_b) >= dur
          largest_start = [slots_a[index_a][0], slots_b[index_b][0]].max
          return [largest_start, largest_start + dur]
        else
          # move on the the next index in the slot with the smallest end time
          if slots_a[index_a][1] < slots_b[index_b][1]
            index_a += 1
          else
            index_b += 1
          end
        end
      end
    end
  end

  attr_reader :slots_a, :slots_b, :dur

  def overlap_size(index_a, index_b)
    [slots_a[index_a][1], slots_b[index_b][1]].min - [slots_a[index_a][0], slots_b[index_b][0]].max
  end
end
