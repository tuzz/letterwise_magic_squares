require "json"

signatures = {}

File.read("foo.json").split("\n").each do |line|
  data = JSON.parse(line)
  squares = data["squares"]
  sums = data["sums"]

  signature = (squares.flatten + sums).sort
  signatures[signature] = data
end

uniques = signatures.values
sorted = uniques.sort_by { |h| h["sums"].first }

sorted.each.with_index do |solution, n|
  puts "**Solution #{n + 1}:**\n"

  solution["squares"].each.with_index do |square, i|
    sum = solution["sums"][i]
    puts "```\n(sum: #{sum})"

    square.each do |row|
      puts row.join(", ")
    end

    puts "```\n\n"
  end
end
