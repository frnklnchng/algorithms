require_relative "static_array"

class DynamicArray
  attr_reader :length, :capacity, :store

  def initialize
    @store, @capacity, @length = StaticArray.new(8), 8, 0
  end

  # O(1)
  def [](index)
    check_index(index)

    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)

    @store[index] = value
  end

  # O(1)
  def pop
    check_length()

    el = @store[@length - 1]
    @length -= 1

    el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible resize.
  def push(val)
    resize! if @length == @capacity

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    check_length()
    
    el = @store[0]

    @length.times {|i| @store[i] = @store[i + 1]}

    @length -= 1

    el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    old, @store = @store.dup, StaticArray.new(@capacity)

    @length.times do |i|
      @store[i + 1] = old[i]
    end

    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if @length == 0 || index < 0 || @length <= index
  end

  def check_length
    raise "index out of bounds" if @length < 1
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    old, @store = @store.dup, StaticArray.new(@capacity * 2)

    @capacity.times do |i|
      @store[i] = old[i]
    end

    @capacity *= 2
  end
end
