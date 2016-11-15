module LetterwiseMagicSquares
  module Sentient
    def self.compile(program)
      file = Tempfile.new
      file.write(program)
      file.close

      `sentient -c -o #{file.path}`
    ensure
      file.unlink
    end

    def self.run(machine_code, length, dimension)
      filename = "/tmp/letter_squares_#{length}_#{dimension}.json"
      File.open(filename, "w") { |f| f.puts machine_code }
      out = `sentient -m lingeling -r #{filename}`

      if out.strip == "{}"
        false
      else
        puts out
        true
      end
    end
  end
end
