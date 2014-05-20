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
        gene = gene.to_i
				gene += 1
				gene %= 3
			end
      mutated << gene
		end
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

  def count
    genes.count
  end
end
