require "minitest/autorun"
require "oxo/board"


describe OXO::Board do

  before do
    @board = OXO::Board.new
  end

  it "should have the correct size" do
    @board.rows.must_equal 3
    @board.cols.must_equal 3
  end
end
