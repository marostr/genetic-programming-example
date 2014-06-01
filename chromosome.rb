GENE_SIZE = 200
#MUTATION_RATE = 0.001
MUTATION_RATE = 0.01
WORD = 'trudne'

class Chromosome

	attr_accessor :genes

	def initialize genes = nil
    size = rand GENE_SIZE + 4
		genes ? self.genes = genes : self.genes = (1..size).map{ rand 3 }.join
	end

	def fitness
    w1 = WORD.split('')
    w2 = to_word.split('')
    fitness = 0
    WORD.length.times do |i|
      break if w2[i].nil?
      dist = -(w1[i].ord - w2[i].ord).abs
      #if dist == 0
      #  fitness += 0
      #else
      fitness += -(w1[i].ord - w2[i].ord).abs
      #end
    end
    fitness += -8*(w1.size - w2.size).abs
	end

  def to_colored_word
    word = self.to_word
    exp = WORD
    res = []
    word.length.times do |i|
      if word[i] == exp[i]
        col = :green
      else
        col = :red
      end
      res << word[i].colorize(col)
    end
    res.insert WORD.size, ' | '
    res.join
  end

  def to_word
    char = "abcdefghijklmnoprstuwxyz"
    word = []
    pos = 0
    len = char.length
    genes.split('').each do |gene|
      if gene == '2'
        pos -= 1
        pos % len
      elsif gene == '1'
        pos += 1
        pos % len
      elsif gene == '0'
        word << char[pos]
      end
    end
    word.join 
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
    length = genes.length < other.genes.length ? genes.length - 1 : other.genes.length - 1
		split = rand(length)
		child1 = genes[0, split] + other.genes[split, other.genes.length]
		child2 = other.genes[0, split] + genes[split, genes.length]
		[Chromosome.new(child1), Chromosome.new(child2)]
	end

	def to_s
		genes.gsub('0', 'w').gsub('1', 'p').gsub('2', 'l')
	end
end
