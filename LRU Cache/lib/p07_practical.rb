require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  map = HashMap.new

  string.each_char do |c|
    map.include?(c) ? map.delete(c) : map.set(c, true)
  end

  return map.count < 2
end
