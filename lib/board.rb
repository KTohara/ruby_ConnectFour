require 'byebug'

class Board
  attr_reader :row, :col, :board

  def initialize
    @row = 6
    @col = 7
    @board = Array.new(@row) { [''] * @col }
  end

  def game_over?
    return true if win? || draw?
    false
  end

  def win?
    diag_connect? || row_connect? || col_connect?
  end

  def draw?

  end

  def diag_connect?

  end

  def row_connect?

  end

  def col_connect?

  end
end

# b = Board.new
# p b.board.all? { |el| el.empty? }