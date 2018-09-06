require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map, @store, @max, @prc = HashMap.new, LinkedList.new, max, prc
  end

  def count
    @map.count
  end

  def get(key)
    if node = @map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
  end
end
