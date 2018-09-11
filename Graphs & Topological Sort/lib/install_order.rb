# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require 'graph'
require 'topological_sort'

def install_order(arr)
  max_id = arr.map {|tuple| tuple.first}.max
  vertices = (1..max_id).map {|x| Vertex.new(x)}

  arr.each do |tuple|
    Edge.new(vertices[tuple.last - 1], vertices[tuple.first - 1])
  end

  topological_sort(vertices).map(&:value)
end
