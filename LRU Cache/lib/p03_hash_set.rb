require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store, @count = Array.new(num_buckets) { Array.new }, 0
  end

  def insert(key)
    resize! if @count == num_buckets

    self[key.hash].push(key)

    @count += 1
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key)

    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
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
