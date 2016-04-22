module OXO
  class Computer

    attr_reader :color

    def initialize(color, delay: 0)
      @color = color
      @delay = delay
    end

    def name
      "oxo"
    end

    def make_move(board)
      sleep @delay

      board.legal_moves.sample
    end
  end
end
