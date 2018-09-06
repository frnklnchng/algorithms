require_relative "heap"

class Array
  def heap_sort!
    prc ||= Proc.new {|a, b| -(a <=> b)}
    
    self.each_index do |i|
      BinaryMinHeap.heapify_up(self, i, &prc)
    end
    
    self.each_index.reverse_each do |i|
      self[0], self[i] = self[i], self[0]
      
      BinaryMinHeap.heapify_down(self, 0, i, &prc)
    end
  end
end
