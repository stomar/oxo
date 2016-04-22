module OXO
  class Human

    attr_reader :color

    def initialize(color)
      @color = color
    end

    def name
      "Human"
    end

    def make_move(board)
      move = :illegal

      while move == :illegal
        print "Your move (1...9, 0/q=quit)? "
        answer = gets.chomp

        move = parse_answer(answer, board)

        puts "Illegal move: #{answer}"  if move == :illegal
      end

      move
    end

    private

    def parse_answer(answer, board)
      case answer
      when "0", "q", "quit"
        :quit
      when /\d/
        number = answer.to_i
        row = (number - 1) / board.rows + 1
        col = (number - 1) % board.cols + 1

        board.legal_move?(row, col) ? [row, col] : :illegal
      else
        :illegal
      end
    end
  end
end
