require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store, @length, @start, @capacity = StaticArray.new(8), 0, 0, 8
  end

  # O(1)
  def [](index)
    check_index(index)

    @store[(@start + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)

    @store[(@start + index) % @capacity] = val
  end

  # O(1)
  def pop
    check_length()

    @length -= 1

    @store[(@start + @length) % @capacity]
  end

  # O(1) ammortized
  def push(val)
    resize! unless @length < @capacity

    @store[(@start + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    check_length()

    el = self[0]
    @length -= 1
    @start += 1

    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! unless @length < @capacity
    
    @start -= 1
    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if @length == 0 || index < 0 || @length <= index
  end

  def check_length
    raise "index out of bounds" if @length < 1
  end

  def resize!
    old, @store = @store.dup, StaticArray.new(@capacity * 2)

    @length.times do |i|
      @store[i] = old[(@start + i) % @capacity]
    end

    @start = 0
    @capacity *= 2
  end
end
