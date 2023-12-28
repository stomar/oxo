# frozen_string_literal: true

module OXO

  # Class for the game board.
  class Board

    attr_accessor :rows, :cols

    def initialize
      @rows, @cols = 3, 3
      @board = Array.new(@rows) { Array.new(@cols) }
    end

    def legal_move?(row, col)
      on_board?(row, col) && !piece_at(row, col)
    end

    def place(color, row, col)
      return  unless legal_move?(row, col)

      @board[row - 1][col - 1] = color
    end

    def legal_moves
      empty_squares = []

      1.upto(rows) do |row|
        1.upto(cols) do |col|
          empty_squares << [row, col]  unless piece_at(row, col)
        end
      end

      empty_squares
    end

    def full?
      !@board.flatten.include? nil
    end

    def win?(color)
      @board.each {|row| return true  if row.uniq == [color] }
      @board.transpose.each {|col| return true  if col.uniq == [color] }
      return true  if @board.flatten.values_at(0, 4, 8).uniq == [color]
      return true  if @board.flatten.values_at(2, 4, 6).uniq == [color]

      false
    end

    def to_s
      output = "\n".dup
      hline = "+---" * @cols << "+\n"

      characters = @board.map {|row| row.map {|pos| pos.to_s.ljust(1) } }

      output << hline
      characters.each do |row|
        output << "| " << row.join(" | ") << " |" << "\n"
        output << hline
      end

      output << "\n"
    end

    private

    def on_board?(row, col)
      (1..@rows).include?(row) && (1..@cols).include?(col)
    end

    def piece_at(row, col)
      return  unless on_board?(row, col)

      @board[row - 1][col - 1]
    end
  end
end
