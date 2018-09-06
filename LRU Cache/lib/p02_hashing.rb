class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0

    self.each_with_index{|el, i| sum += el.hash * i.hash}

    sum
  end
end

class String
  def hash
    self.chars.map{|c| c.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
