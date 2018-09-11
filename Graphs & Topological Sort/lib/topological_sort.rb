require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  queue = Queue.new
  counts = Hash.new
  sorted = Array.new

  vertices.each do |v| 
    queue.enq(v) if v.in_edges.empty?
    counts[v] = v.in_edges.count
  end
  
  until queue.empty?
    current = queue.pop

    sorted.push(current)

    current.out_edges.each do |e|
      to_vertex = e.to_vertex

      counts[to_vertex] -= 1

      queue.enq(to_vertex) if counts[to_vertex].zero?
    end
  end

  counts.values.all? {|x| x == 0} ? sorted : Array.new
end
