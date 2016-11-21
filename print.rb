require "json"

signatures = {}

File.read("/Users/chris/Desktop/smallest").split("\n").each do |line|
  data = JSON.parse(line)
  squares = data["squares"]
  sums = data["sums"]

  signature = (squares.flatten + sums).sort
  signatures[signature] = data
end

uniques = signatures.values
sorted = uniques.sort_by { |h| h["sums"].first }

freqs = Hash.new(0)

sorted.each.with_index do |solution, n|
  puts "**Solution #{n + 1}:**\n"

  square1, square2, square3 = solution["squares"]
  sum1, sum2, sum3 = solution["sums"]

  print "```\n(sum: #{sum1})"
  print "                          (sum: #{sum2})"
  puts "         (sum: #{sum3})"

  3.times do |i|
    print square1[i].join(", ")

    if i == 1
      print "  =>  "
    else
      print "      "
    end

    print square2[i].join(", ")

    if i == 1
      print "  =>  "
    else
      print "      "
    end

    puts square3[i].join(", ")
  end

  puts "```\n\n"

  freqs[sum1] += 1
end

groups = freqs.group_by(&:last).map { |k, arrs| [k, arrs.map(&:first)] }
sorted = groups.sort_by { |k, v| -k }

sorted.each do |k, v|
  puts "#{k} | #{v}"
end
