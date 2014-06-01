require_relative 'chromosome'
require_relative 'population'
require 'colorize'

WORD = 'badania'

NUM_GENERATIONS = 20000
CROSSOVER_RATE = 0.7

population = Population.new
population.seed!
first_fitness = population.average_fitness
first_max_fitness = population.max_fitness
 
1.upto(NUM_GENERATIONS).each do |generation|

  offspring = Population.new
  
  while offspring.count <= population.count-12
    offspring.chromosomes.uniq!{|ch| ch.genes}
    offspring.chromosomes.delete ""

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

  # TERMINAL OUTPUT
  system 'clear'
  puts "TARGET: #{WORD.colorize(:green)}"
  puts "Generation #{generation} - Average: #{population_fitness.round(2).to_s.colorize(average_color)} - Max: #{population_max_fitness.to_s.colorize(max_color)} \n"
  population.chromosomes.take(10).each_with_index do |ch, i|
    puts "Best word #{i+1}: #{ch.to_colored_word}"
    puts "Code: #{ch.to_s}\n"
  end

  # FILE OUTPUT
  f = File.open("populations/population_#{generation}.txt", 'w+')
  f << population.to_file

  offspring.chromosomes
  population.best_chromosomes(10).each{|ch| offspring.chromosomes << ch }
  
  population = offspring
  population.sort!

  if population.best_word == WORD
    puts "\nFinal population:\n" + population.inspect
    break
  end
end
