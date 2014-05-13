GENE_SIZE = 64
MUTATION_RATE = 0.001
#MUTATION_RATE = 0.01

class Chromosome

  attr_accessor :genes

  def initialize genes = nil
    genes ? self.genes = genes : self.genes = (1..GENE_SIZE).map{ rand 3 }.join
  end

  def fitness
    genes.count('2') + genes.count('1')/2
  end

  def mutate!
    mutated = []
    genes.split('').each do |gene|
      if rand < MUTATION_RATE
        gene += 1
        gene %= 3
      end
    end
    mutated << gene
    self.genes = mutated.join
  end
      
  def & other
    split = rand(genes.length + 1)
    child1 = genes[0, split] + other.genes[split, other.genes.length]
    child2 = other.genes[0, split] + genes[split, genes.length]
    [Chromosome.new(child1), Chromosome.new(child2)]
  end

  def to_s
    genes
  end
end
c1 = Chromosome.new
c2 = Chromosome.new
puts 'Chromosome 1'
puts c1
puts 'Fitness'
puts c1.fitness
puts '----'
puts 'Chromosome 2'
puts c2
puts 'Fitness'
puts c2.fitness
puts '----'
child1, child2 = c1 & c2
puts 'Child 1'
puts child1
puts 'Fitness'
puts child1.fitness
puts '----'
puts 'Child 2'
puts child2
puts 'Fitness'
puts child2.fitness
