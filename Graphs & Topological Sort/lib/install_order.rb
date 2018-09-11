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
  verts = (1..max_id).map {|x| Vertex.new(x)}

  arr.each {|tuple| Edge.new(verts[tuple.last - 1], verts[tuple.first - 1])}

  topological_sort(verts).map(&:value)
end
