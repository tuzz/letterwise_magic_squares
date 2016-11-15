$LOAD_PATH.unshift("lib")
require "letterwise_magic_squares"

task :run do
  LetterwiseMagicSquares.search(
    length: Integer(ENV.fetch("LENGTH")),
    dimension: Integer(ENV.fetch("DIMENSION")),
  )
end

task default: :run
