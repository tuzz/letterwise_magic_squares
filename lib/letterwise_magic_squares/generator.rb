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
          # The number of letters in 1..19
          # 0 is prepended for convenience
          one_lookup = [0, 2, 4, 5, 6, 4, 3, 4, 4, 4, 3, 4, 5, 6, 8, 6, 5, 7, 7, 7];

          ten_lookup = [0, 0, 5, 6, 8, 9, 8, 8, 11, 11];

          teens = [1, 7, 9];

          function^ numberOfLettersUpto1000 (n, isMille) {
            sum = 0;

            hundreds, remainder = n.divmod(100);
            tens, ones = remainder.divmod(10);
            ones += teens.include?(tens) ? 10 : 0;

            sum += ten_lookup[tens];
            sum += one_lookup[ones];
            sum += ones == 1 && tens > 0 ? 2 : 0;
            sum += tens == 8 && ones == 0 ? 1 : 0;

            # Add 'cent(s)'
            sum += hundreds > 0 ? 4 : 0;
            sum += hundreds > 1 && tens == 0 && ones == 0 ? 1 : 0;
            sum += hundreds > 1 ? one_lookup[hundreds]: 0;

            # Remove 'un' infront of 'mille'
            sum -= isMille && n == 1 ? 2 : 0;

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

        terms += "\ntotal += numberOfLettersUpto1000(remainder, false);"

        mille = true
        exponentials.each do |(digits, word)|
          terms += "\ntotal += numberOfLettersUpto1000(#{word}s, #{mille});"
          terms += "\ntotal += #{word}s.zero? ? 0 : #{word.length};"
          terms += "\ntotal += #{word}s > 1 ? 1 : 0;" unless mille

          mille = false
        end

        terms
      end

      def calculate_exponentiated_terms(max)
        digits = max.to_s.length
        exponentials = (digits - 1) / 3

        1.upto(exponentials).map do |exp|
          word = I18n.with_locale(:fr) { (1000 ** exp).to_words }
          word = word.gsub("un ", "").gsub(/[^a-z]/, "")

          [exp * 3, word]
        end
      end
    end
  end
end
