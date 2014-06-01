POPULATION_SIZE = 50

class Population
  
  attr_accessor :chromosomes

  def initialize
    self.chromosomes = Array.new
  end

  def seed!
    POPULATION_SIZE.times { chromosomes << Chromosome.new}
  end

  def fitness
    chromosomes.collect &:fitness
  end

  def total_fitness
    fitness.inject { |total, value| total + value }
  end

  def max_fitness
    fitness.max
  end

  def best_word
    chromosomes.first.to_colored_word 
  end

  def best_chromosome
    chromosomes.first
  end

  def sort
    self.chromosomes = self.chromosomes.sort_by{|ch| ch.fitness}.reverse
  end

  def average_fitness
    total_fitness.to_f / chromosomes.length
  end

  def count
    chromosomes.count
  end

  def inspect
    ch = []
    self.sort.each { |chromosome| ch << chromosome.to_s.gsub('0', 'w').gsub('1', 'p').gsub('2', 'l') << "Word: #{chromosome.to_word}" << "Fitness: #{chromosome.fitness}\n"}
    ch.join("\n")
  end

  def select
    if rand < 0.7
      chromosomes.take(self.count/3).sample 
    else
      chromosomes.drop(self.count/3).sample
    end
  end
end
