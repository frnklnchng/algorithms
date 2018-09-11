class Vertex
  attr_reader :value
  attr_accessor :in_edges, :out_edges

  def initialize(value)
    @value, @in_edges, @out_edges = value, Array.new, Array.new
  end
end

class Edge
  attr_reader :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex, @to_vertex = from_vertex, to_vertex
    @cost = cost 

    to_vertex.in_edges.push(self)
    from_vertex.out_edges.push(self)
  end

  def destroy!
    @to_vertex.in_edges.delete(self)
    @from_vertex.out_edges.delete(self)

    @from_vertex, @to_vertex = nil, nil
  end
end
