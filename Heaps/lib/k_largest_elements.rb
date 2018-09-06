require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new

  array.each {|el| heap.push(el)}

  heap.extract until heap.count == k
    
  heap.store
end
