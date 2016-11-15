module LetterwiseMagicSquares
  module Generator
    class << self
      def bits
        @bits ||= 10
      end

      def bits=(bits)
        @bits = bits
      end

      def max_value
        2 ** (bits - 1) - 1
      end

      def generate(length:, dimension:)
        <<-SNT
          #{magic_square}
          #{letter_square}
          #{lookup_table}

          array#{dimension}<array#{dimension}<int#{bits}>> square;
          square.magicSquare!;

          squares = [];
          squares = squares.push(square);

          #{length - 1}.times(function^ (i) {
            square = letterSquare(square);
            square.magicSquare!;

            squares = squares.push(square);
          });

          sums = squares.map(function (square) {
            return square.first.sum;
          });

          expose squares, sums;
        SNT
      end

      def magic_square
        <<-SNT
          function^ magicSquare! (square) {
            left_diagonal = square.map(function (row, i) {
              return row[i];
            }).sum;

            right_diagonal = square.map(function (row, i) {
              return row.reverse[i];
            }).sum;

            invariant left_diagonal == right_diagonal;

            flat = [];

            square.each(function^ (row) {
              invariant row.sum == left_diagonal;

              row.each(function^ (n) {
                invariant n.positive?;
                flat = flat.push(n);
              });
            });

            square.transpose.each(function^ (column) {
              invariant column.sum == left_diagonal;
            });

            invariant flat.uniq?;
          };
        SNT
      end

      def letter_square
        <<-SNT
          function^ letterSquare (square) {
            return square.map(function^ (row) {
              return row.map(*numberOfLettersIn);
            });
          };
        SNT
      end

      def lookup_table
        <<-SNT
          # The number of letters in one..nine
          # 0 is prepended for convenience
          one_lookup = [0, 3, 3, 5, 4, 4, 3, 5, 5, 4];

          # The number of letters in ten..ninety
          ten_lookup = [0, 3, 6, 6, 5, 5, 5, 7, 6, 6];

          # The delta of (eleven..nineteen) - ten - (one..nine)
          teen_lookup = [0, 0, 0, 0, 1, 0, 1, 1, 0, 1];

          function^ numberOfLettersUpto1000 (n) {
            sum = 0;

            hundreds, modulo_100 = n.divmod(100);
            tens, remainder = modulo_100.divmod(10);

            # Add the characters from the ones
            sum += one_lookup[remainder];

            # Add the characters from the tens
            sum += ten_lookup[tens];

            # Add the teen delta if 11 <= modulo_100 <= 19
            sum += modulo_100.between?(11, 19) ? teen_lookup[remainder] : 0;

            # Add the characters from the hundreds
            sum += one_lookup[hundreds];
            sum += hundreds.zero? ? 0 : 7;

            # Add the word 'and'
            and_required = hundreds != 0 && modulo_100 != 0;
            sum += and_required ? 3 : 0;

            return sum;
          };

          function^ numberOfLettersIn (n) {
            total = 0;

            remainder = n;
            #{generate_exponentiated_terms(max_value)}

            return total;
          };
        SNT
      end

      def generate_exponentiated_terms(max)
        terms = ""

        exponentials = calculate_exponentiated_terms(max)

        exponentials.reverse.each do |(digits, word)|
          terms += "\n#{word}s, remainder = remainder.divmod(1#{"0" * digits});"
        end

        terms += "\ntotal += numberOfLettersUpto1000(remainder);"

        exponentials.each do |(digits, word)|
          terms += "\ntotal += numberOfLettersUpto1000(#{word}s);"
          terms += "\ntotal += #{word}s.zero? ? 0 : #{word.length};"
        end

        terms
      end

      def calculate_exponentiated_terms(max)
        digits = max.to_s.length
        exponentials = (digits - 1) / 3

        1.upto(exponentials).map do |exp|
          word = (1000 ** exp).to_words
          word = word[4..-1].gsub(/[^a-z]/, "")

          [exp * 3, word]
        end
      end
    end
  end
end
