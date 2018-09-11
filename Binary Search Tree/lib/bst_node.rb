class BSTNode
  attr_reader :value
  attr_accessor :left, :right
  
  def initialize(value)
    @value, @left, @right = value, nil, nil
  end
end
