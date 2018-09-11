
def kth_largest(tree_node, k)
  arr = traverse(tree_node)

  arr[arr.length - k]
end

def traverse(tree_node)
  return Array.new if tree_node.nil?

  left, right = traverse(tree_node.left), traverse(tree_node.right)

  left + [tree_node] + right
end