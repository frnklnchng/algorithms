class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key, @val, @next, @prev = key, val, nil, nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next, self.prev = nil, nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head, @tail = Node.new, Node.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each{|node| return node.val if node.key == key}
  end
  
  def include?(key)
    self.any?{|node| node.key == key}
  end

  def append(key, val)
    node = Node.new(key, val)
    prev = @tail.prev 

    prev.next, node.prev = node, prev
    @tail.prev, node.next = node, @tail
  end

  def update(key, val)
    self.each{|node| node.val = val if node.key == key}
  end

  def remove(key)
    self.each{|node| return node.remove if node.key == key}
  end

  def each
    curr = @head.next
    
    until curr == @tail
      yield curr

      curr = curr.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
