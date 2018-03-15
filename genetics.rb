class Chromosome
  SIZE = 7
  def initialize(sequence)
    @value = sequence ? sequence.split("") : Array.new(SIZE) { ["0", "1"].sample }
  end

  CAPACITY = 20
  def fitness
    weights = [2, 3, 6, 7, 5, 9, 4]
    values  = [6, 5, 8, 9, 6, 7, 3]

    w = weights
        .map
        .with_index { |w, idx| @value[idx].to_i * w }
        .inject(:+)

    v = values
        .map
        .with_index { |v, idx| @value[idx].to_i * w }
        .inject(:+)

    w > CAPACITY ? 0 : v
  end

  def select(population)
    population.sample(2)
  end
end


