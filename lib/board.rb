# frozen_string_literal: true
require 'byebug'

class Board
  attr_reader :rows, :cols, :grid

  def initialize
    @rows = 6
    @cols = 7
    @grid = Array.new(@rows) { [''] * @cols }
  end

  def game_over?
    win? || draw?
  end

  def win?
    cols = grid.transpose
    diag = diagonal_left(grid)

    four_in_a_row?(grid) || four_in_a_row?(cols) || four_in_a_row?(diag)
    # diag_four? || four_in_a_row?(matrix) || col_four?
  end

  def draw?; end

  def diagonal_left(matrix)
    lower = (0...rows - 3).map do |i|
      (0...rows - i).map do |j|
        matrix[i + j][j]
      end
    end
    
    upper = (1...cols- 3).map do |i|
      (0...rows - i + 1).map do |j|
        matrix[j][i + j]
      end
    end

    lower + upper
  end

  def diagonal_right(matrix)
    upper = (4..rows).map do |i|
      (0...i).map do |j|
        matrix[i - j - 1][j]
      end
    end

    lower = (0...cols- 4).map do |i|
      (i...rows).map do |j|
        matrix[j][i - j - 1]
      end
    end

    upper + lower
  end

  def four_in_a_row?(matrix)
    matrix.each do |rows|
      rows.each_cons(4).each do |fours|
        return true if fours.uniq.size == 1 && !fours.first.empty?
      end
    end
    false
  end
end

b = Board.new
grid = [
[ 0,  1,  2,  3,  4,  5,  6],
[ 7,  8,  9, 10, 11, 12, 13], 
[14, 15, 16, 17, 18, 19, 20], 
[21, 22, 23, 24, 25, 26, 27], 
[28, 29, 30, 31, 32, 33, 34], 
[35, 36, 37, 38, 39, 40, 41]]

p b.diagonal_left(grid)
p b.diagonal_right(grid)