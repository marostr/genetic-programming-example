require_relative 'chromosome'
require_relative 'population'
require 'colorize'

NUM_GENERATIONS = 10000
CROSSOVER_RATE = 0.7

population = Population.new
population.seed!
first_fitness = population.average_fitness
first_max_fitness = population.max_fitness
 
1.upto(NUM_GENERATIONS).each do |generation|
 
  offspring = Population.new
  
  while offspring.count <= population.count-2
    offspring.chromosomes.uniq!{|ch| ch.genes}

    parent1 = population.select
    parent2 = population.select
 
    if rand <= CROSSOVER_RATE
      child1, child2 = parent1 & parent2
    else
      child1 = Chromosome.new
      child2 = Chromosome.new
    end
 
    child1.mutate!
    child2.mutate!
    
    if offspring.count.even?
      offspring.chromosomes << child1 << child2
    else
      offspring.chromosomes << [child1, child2].sample
    end
  end
 
  population_fitness = population.average_fitness
  population_max_fitness = population.max_fitness
  average_color = population_fitness < first_fitness ? :red : :green
  max_color = population_max_fitness < first_max_fitness ? :red : :green

  system 'clear'
  puts "Generation #{generation} - Average: #{population_fitness.round(2).to_s.colorize(average_color)} - Max: #{population_max_fitness.to_s.colorize(max_color)} - Best word: #{population.best_word}"
  f = File.open("syf/population_#{generation}.txt", 'w+')
  f << population.inspect

  #offspring.chromosomes << population.best_chromosome
  
  population = offspring
end
 
#puts "Final population: " + population.inspect
