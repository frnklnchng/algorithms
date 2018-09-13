class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = { 
      1 => [[1]], 
      2 => [[1, 1], [2]], 
      3 => [[1, 1, 1], [1, 2], [2, 1], [3]]
    }

  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2 * (n - 1) - 1)
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)

    @frog_cache[n]
  end

  def frog_cache_builder(n)
    return @frog_cache if n < 4

    (4..n).each do |i|
      step = Array.new

      (1..3).each do |j|
        jump = @frog_cache[i - j].map {|arr| arr + [j]}
        step += jump
      end

      @frog_cache[i] = step
    end
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)

    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    step = Array.new

    (1..3).each do |i|
      jump = frog_hops_top_down_helper(n - i).map {|arr| arr + [i]}
      step += jump
    end

    @frog_cache[n] = step
  end

  def super_frog_hops(n, k)
    return [[]] if n == 0
    return [[1]] if n == 1

    ways = Array.new

    (1..k).each do |jump|
      break if jump > n

      step = super_frog_hops(n - jump, k)

      step.each {|prev| ways.push(prev + [jump])}
    end

    ways
  end

  def knapsack(weights, values, capacity)
    knapsack_table(weights, values, capacity)
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    table = Array.new

    (0..capacity).each do |i|
      table[i] = Array.new

      (0...weights.length).each do |j|
        if i == 0
          table[i][j] = 0
        elsif j == 0
          table[i][j] = weights[j] > i ? 0 : values[j]
        else
          x = table[i][j - 1]
          y = weights[j] > i ? 0 : table[i - weights[j]][j - 1] + values[j]

          table[i][j] = [x, y].max
        end
      end
    end

    return table.last.last
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
