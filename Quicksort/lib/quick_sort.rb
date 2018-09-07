class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array unless array.length > 1

    pivot = array.first
    left, right = Array.new, Array.new

    (1...array.length).each do |i|
      array[i] < pivot ? left.push(array[i]) : right.push(array[i])
    end
    
    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array unless length > 1

    prc ||= Proc.new {|a, b| a <=> b}

    pivot = self.partition(array, start, length, &prc)

    left = pivot - start
    right = length - left - 1

    self.sort2!(array, 0, left, &prc)
    self.sort2!(array, pivot + 1, right, &prc)

    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new {|a, b| a <=> b}

    pivot = start + 1

    (pivot...(start + length)).each do |i|
      if prc.call(array[start], array[i]) > 0
        array[pivot], array[i] = array[i], array[pivot]
        pivot += 1
      end
    end

    pivot -= 1

    array[start], array[pivot] = array[pivot], array[start]

    pivot
  end
end
