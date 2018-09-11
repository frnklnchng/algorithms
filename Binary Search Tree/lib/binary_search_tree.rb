# There are many ways to implement these methods, feel free to add arguments 
# to methods as you see fit, or to create helper methods.

require 'bst_node'

class BinarySearchTree
  attr_reader :root
  
  def initialize
    @root = nil
  end

  def insert(value)
    @root = insert_rec(@root, value)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    return tree_node if tree_node.value == value

    node = value < tree_node.value ? tree_node.left : tree_node.right

    find(value, node)
  end

  def delete(value)
    @root = delete_rec(@root, value)
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?

    left, right = depth(tree_node.left), depth(tree_node.right)

    left > right ? left + 1 : right + 1
  end 

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?

    left, right = depth(tree_node.left), depth(tree_node.right)
    balanced = (left - right).abs > 1 ? false : true

    is_balanced?(tree_node.left) && is_balanced?(tree_node.right) && balanced
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    
    arr.push(tree_node.value)

    in_order_traversal(tree_node.right, arr) if tree_node.right
    
    arr
  end


  private
  # optional helper methods go here:

  def insert_rec(node, value)
    return BSTNode.new(value) if node.nil?

    if value <= node.value
      node.left = insert_rec(node.left, value)
    else
      node.right = insert_rec(node.right, value)
    end

    node
  end

  def delete_rec(node, value)
    return remove(node) if value == node.value

    if value <= node.value
      node.left = delete_rec(node.left, value)
    else
      node.right = delete_rec(node.right, value)
    end

    node
  end

  def remove(node)
    return nil if node.left.nil? && node.right.nil?
    return node.left if node.left && node.right.nil?
    return node.right if node.right && node.left.nil?
    return reassign(node)
  end

  def reassign(node)
    promoted = maximum(node.left)

    if promoted.left
      parent = node.left
      max = maximum(node.left.right)
      parent.right = max.left
    end

    promoted
  end
end
