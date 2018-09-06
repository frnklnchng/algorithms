class MaxIntSet
  def initialize(max)
    @max, @store = max, Array.new(max)
  end

  def insert(num)
    is_valid?(num)
    validate!(num)
  end

  def remove(num)
    is_valid?(num)

    @store[num] = nil
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
    @store[num] = true
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]

    bucket.push(num) if bucket
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num) if self[num]
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    i = num % num_buckets

    @store[i]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store, @count = Array.new(num_buckets) { Array.new }, 0
  end

  def insert(num)
    resize! if @count == num_buckets

    self[num].push(num) if self[num]

    @count += 1
  end

  def remove(num)
    self[num].delete(num)

    @count -= 1
  end

  def include?(num)
    self[num].include?(num) if self[num]
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    index = num % num_buckets 

    @store[index]
  end

  def num_buckets
    @store.length
  end

  def resize!
    arr = Array.new

    @store.each {|el| arr.concat(el)}

    @store = Array.new(num_buckets * 2) {Array.new}
    
    arr.each {|el| @store[el % num_buckets].push(el)}
  end
end
