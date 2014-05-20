POPULATION_SIZE = 24

class Population
  
  attr_accessor :chromosomes

  def initialize
    self.chromosomes = Array.new
  end

  def seed!
    POPULATION_SIZE.times { chromosomes << Chromosome.new }
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

  def average_fitness
    total_fitness.to_f / chromosomes.length
  end

  def count
    chromosomes.count
  end

  def inspect
    ch = []
    chromosomes.each { |chromosome| ch << chromosome.to_s.gsub('0', 'l').gsub('1', 'p').gsub('2', 'w') }
    ch.join("\n")
  end

  def select
    rand_selection = rand(total_fitness)
 
    total = 0
    chromosomes.each_with_index do |chromosome, index|
      total += chromosome.fitness
      return chromosome if total > rand_selection || index == chromosomes.count - 1
    end
  end
end
