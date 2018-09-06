class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store, @prc = Array.new, prc || Proc.new {|a, b| a <=> b}
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extract = @store.pop

    self.class.heapify_down(@store, 0, @store.length, &prc)
    
    extract
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, @store.length - 1, @store.length, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    arr = Array.new

    i1 = parent_index * 2 + 1
    i2 = parent_index * 2 + 2

    arr.push(i1) if i1 < len
    arr.push(i2) if i2 < len
    
    arr
  end

  def self.parent_index(child_index)
    child_index == 0 ? raise("root has no parent") : (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b}

    children = BinaryMinHeap.child_indices(len, parent_idx)

    return array if children.empty?
    
    i = prc.call(array[children[0]], array[children[1]]) if children.length == 2
    child_idx = i == 1 ? children[1] : children[0]
    parent, child = array[parent_idx], array[child_idx]

    if prc.call(parent, child) == 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]

      return BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|a, b| a <=> b}
    
    return array if child_idx == 0

    parent_idx = BinaryMinHeap.parent_index(child_idx)
    parent, child = array[parent_idx], array[child_idx]

    if prc.call(parent, child) > -1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]

      return BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
    end

    array
  end
end
