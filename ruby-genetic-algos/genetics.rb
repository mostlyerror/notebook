class Chromosome
  SIZE = 10
  CAPACITY = 20
  attr_reader :genome
  def initialize(genome_string)
    @genome = genome_string ? genome_string.split("") : Array.new(SIZE) { ["0", "1"].sample }
  end

  def fitness
    weights = [2, 3, 6, 7, 5, 9, 4]
    values  = [6, 5, 8, 9, 6, 7, 3]

    w = weights.map.with_index {|w, idx| @genome[idx].to_i * w }.inject(:+)
    return 0 if w > CAPACITY
    values.map.with_index {|v, idx| @genome[idx].to_i * v }.inject(:+)
  end

  def crossover(selection, index, chromosome)
    cr1 = selection[0][0..index] + selection[1][index..-1]
    cr2 = selection[1][0..index] + selection[0][index..-1]
    [Chromosome.new(cr1), Chromosome.new(cr2)]
  end

  def mutate(probability_of_mutation)
  @genome = @genome.map {|ch| rand < probability_of_mutation ? invert(ch) : ch }
  end

  def invert(binary)
    binary == "0" ? "1" : "0"
  end
end


class GeneticAlgorithm
  def select(population)
    population.sample 2
  end

  def run(iterations)
    # initial population
    population = Array.new(100) { Chromosome.new }
    current_generation = population
    next_generation    = []
    iterations.times do
      (population.size / 2).times do
        # selection
        selection = crossover(select(current_generation), rand(0..SIZE), chromosome)

        # mutation
        selection[0].mutate(p_mutation)
        selection[1].mutate(p_mutation)
      end

      current_generation = next_generation
      next_generation = []
    end

    current_generation.max_by { |chr| chr.fitness }
  end
end
