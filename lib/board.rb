# frozen_string_literal: true

require_relative 'display'

# Logic for Connect Four board
class Board
  include Display

  attr_reader :grid, :grid_rows, :grid_cols

  def initialize
    @grid_rows = 6
    @grid_cols = 7
    @grid = Array.new(@grid_rows) { [''] * @grid_cols }
  end

  def add_token(column, token)
    row, col = find_empty_pos(column)
    grid[row][col] = token
  end

  def find_empty_pos(input_num)
    col = input_num - 1 # col has to adjust for non-zero index
    col_check = (0...grid_rows).map { |row| grid[row][col] }
    return [grid_rows - 1, col] if col_check.all?(&:empty?)
    return nil if col_check.none?(&:empty?)

    # adjust row by -1 for slot 'above' the last piece
    row = col_check.find_index { |cell| !cell.empty? } - 1
    [row, col]
  end

  def valid_move?(input)
    return false unless input.match?(/^[1-7]{1}$/)

    num = input.to_i - 1
    grid.any? { |row| row[num].empty? }
  end

  def game_over?
    win? || draw?
  end

  def win?
    return if empty_board?

    columns = grid.transpose
    diagonals = diagonal_left(grid) + diagonal_right(grid)
    four_in_a_row?(grid) || four_in_a_row?(columns) || four_in_a_row?(diagonals)
  end

  def draw?
    grid.flatten.none?(&:empty?)
  end

  def empty_board?
    grid.flatten.all?(&:empty?)
  end

  def diagonal_left(matrix)
    lower = (0...grid_rows - 3).map do |i|
      (0...grid_rows - i).map { |j| matrix[i + j][j] }
    end
    upper = (1...grid_cols - 3).map do |i|
      (0...grid_rows - i + 1).map { |j| matrix[j][i + j] }
    end

    lower + upper
  end

  def diagonal_right(matrix)
    upper = (4..grid_rows).map do |i|
      (0...i).map { |j| matrix[i - j - 1][j] }
    end
    lower = (0...grid_cols - 4).map do |i|
      (i...grid_rows).map { |j| matrix[j][i - j - 1] }
    end

    upper + lower
  end

  def four_in_a_row?(matrix)
    matrix.each do |rows|
      rows.each_cons(4) do |fours|
        return true if fours.uniq.size == 1 && !fours.first.empty?
      end
    end
    false
  end

  def to_s
    board = grid
            .map { |row| display_rows(row) } # sends to Display
            .join("\n")

    "#{BORDER_TOP}\n#{board}\n#{BORDER_BOTTOM}"
  end
end
