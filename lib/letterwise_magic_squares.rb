require "numbers_and_words"
require "tempfile"
require "json"

require "letterwise_magic_squares/generator"
require "letterwise_magic_squares/sentient"

module LetterwiseMagicSquares
  def self.search(length:, dimension:)
    puts "Searching for length=#{length}, dimension=#{dimension}"

    4.upto(100).each do |bits|
      puts "Checking up to #{2 ** bits}..."

      Generator.bits = bits
      program = Generator.generate(length: length, dimension: dimension)

      machine_code = Sentient.compile(program)

      solved = Sentient.run(machine_code, length, dimension)
      break if solved
    end
  end
end
