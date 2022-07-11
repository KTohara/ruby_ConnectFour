# frozen_string_literal: true

require 'board'

describe Board do
  subject(:board) { described_class.new }
  let(:p1) { :black }
  let(:p2) { :red }

  let(:full_column) { [
    ['', '', p2, '', '', '', ''],
    ['', '', p2, '', '', '', ''],
    ['', '', p2, '', '', '', ''],
    ['', '', p1, '', '', '', ''],
    ['', '', p1, '', '', '', ''],
    ['', '', p1, '', '', '', '']
  ] }

  describe '#initialize' do
    it 'should set @rows to 6' do
      expect(board.instance_variable_get(:@rows)).to eq(6)
    end

    it 'should set @cols to 7' do
      expect(board.instance_variable_get(:@cols)).to eq(7)
    end

    it 'creates a nested array with 42 elements' do
      board_size = board.grid.flatten.length
      expect(board_size).to eq(42)
    end

    it 'should all be empty strings' do
      board_cells = board.grid.flatten
      expect(board_cells).to all(be_empty)
      expect(board_cells).to all(be_a(String))
    end
  end

  describe '#add_token' do
    it 'should take a integer between 1 to 7 as an argument' do
      expect(board).to receive(:add_token).with(1..7, p1)
      board.add_token(1..7, p1)
    end

    context 'when a token is placed on the board' do
      let(:token_in_col_three) { [
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', p1, '', '', '', '']
      ] }

      it 'should be placed in the correct column' do
        # pos = [5, 2]
        # allow(board).to receive(:check_column).and_return(pos)
        board.add_token(3, p1)
        expect(board.grid).to eq(token_in_col_three)
      end
    end
  end

  describe '#find_empty_pos' do
    it 'should return the first empty x, y coordinate from a given column' do
      token_in_col_three = [
        ['', '', '', '', '', '', ''],
        ['', '', p1, '', '', '', ''],
        ['', '', p1, '', '', '', ''],
        ['', '', p1, '', '', '', ''],
        ['', '', p1, '', '', '', ''],
        ['', '', p1, '', '', '', '']
        # 1   2   3   4   5   6   7
      ]
      # argument will be received as non-zero index,
      # but will return in zero index format
      board.instance_variable_set(:@grid, token_in_col_three)
      expect(board.find_empty_pos(3)).to eq([0, 2])
    end

    it 'should place a token on an empty board' do
      expect(board.find_empty_pos(3)).to eq([5, 2])
    end

    it 'should return nil if no empty spot is found' do
      board.instance_variable_set(:@grid, full_column)
      expect(board.find_empty_pos(3)).to be_nil
    end
  end

  describe '#valid_move?' do
    context 'when argument passed is an integer between 1 to 7' do
      it 'returns true' do
        expect(board.valid_move?('5')).to be true
      end

      it 'returns false when argument is a not a digit' do
        expect(board.valid_move?('a')).to be false
        expect(board.valid_move?('!')).to be false
      end
    end

    it 'returns false when there is no space in the column' do
      board.instance_variable_set(:@grid, full_column)
      expect(board.valid_move?('3')).to be false
    end
  end

  describe '#game_over?' do
    context 'when game is a #win?' do
      it 'returns true' do
        allow(board).to receive(:win?).and_return(true)
        expect(board).to be_game_over
      end
    end

    context 'when game is a #draw?' do
      it 'returns true' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(true)
        expect(board).to be_game_over
      end
    end

    context 'when neither #win or #draw' do
      it 'retrurns false' do
        allow(board).to receive(:win?).and_return(false)
        allow(board).to receive(:draw?).and_return(false)
        expect(board).to_not be_game_over
      end
    end
  end

  describe '#win?' do
    context 'when there is a row four-in-a-row' do
      it 'returns true' do
        allow(board).to receive(:empty_board?).and_return(false)
        allow(board).to receive(:four_in_a_row?).once.and_return(true)
        expect(board).to be_win
      end
    end

    context 'when there is a column four-in-a-row' do
      it 'returns true' do
        allow(board).to receive(:empty_board?).and_return(false)
        allow(board).to receive(:four_in_a_row?).twice.and_return(false, true)
        expect(board).to be_win
      end
    end

    context 'when there is a diagonal four-in-a-row' do
      it 'returns true' do
        allow(board).to receive(:empty_board?).and_return(false)
        allow(board).to receive(:four_in_a_row?).at_least(3).times.and_return(false, false, true)
        expect(board).to be_win
      end
    end

    context 'when there is no four-in-a-row' do
      it 'returns false' do
        allow(board).to receive(:four_in_a_row?).exactly(3).times.and_return(false, false, false)
        expect(board).to_not be_win
      end
    end
  end

  describe '#draw' do
    context 'when the board is full' do
      let(:grid) { [
        [p1, p1, p1, p1, p1, p1, p1],
        [p1, p1, p1, p1, p1, p1, p1],
        [p1, p1, p1, p1, p1, p1, p1],
        [p1, p1, p1, p1, p1, p1, p1],
        [p1, p1, p1, p1, p1, p1, p1],
        [p1, p1, p1, p1, p1, p1, p1]
      ] }

      it 'should return true' do
        board.instance_variable_set(:@grid, grid)
        expect(board).to be_draw
      end
    end

    context 'when the board is not full' do
      let(:grid) { [
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', p1, ''],
        ['', '', '', '', p2, p2, ''],
        ['', '', '', p1, p1, p1, p1]
      ] }

      it 'should return false' do
        board.instance_variable_set(:@grid, grid)
        expect(board).not_to be_draw
      end
    end
  end

  describe '#empty_board?' do
    context 'when the board is empty' do
      it 'should return true' do
        expect(board).to be_empty_board
      end
    end
  end

  describe '#four_in_a_row?' do
    context 'when there is a row with four-in-a-row' do
      let(:grid) { [
        ['', '', '', p1, p1, p1, p1],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '']
      ] }

      it 'returns true' do
        expect(board.four_in_a_row?(grid)).to be true
      end
    end

    context 'when there is no row with four-in-a-row' do
      it 'returns false' do
        expect(board.four_in_a_row?(board.grid)).to_not be true
      end
    end
  end

  describe '#diagonal_left' do
    let(:grid) { [
      ['', 'x', '', 'y', '', '', ''],
      ['o', p1, 'x', p1, 'y', '', ''],
      ['', 'o', p1, 'x', p1, 'y', ''],
      ['', 'z', 'o', p1, '', p1, 'y'],
      ['', '', 'z', 'o', p1, '', p1],
      ['', '', '', 'z', '', '', '']
    ] }

    let(:diagonals) { [
      ['', 'z', 'z', 'z'],
      ['o', 'o', 'o', 'o', ''],
      ['', p1, p1, p1, p1, ''],
      ['x', 'x', 'x', '', '', ''],
      ['', p1, p1, p1, p1],
      ['y', 'y', 'y', 'y']
    ] }

    it 'returns a nested array with all diagonals from left to right' do
      expect(board.diagonal_left(grid)).to match_array(diagonals)
    end
  end

  describe 'diagonal_right' do
    let(:grid) { [
      ['', '', '', 'x', '', 'o', ''],
      ['', '', 'x', p1, 'o', '', 'y'],
      ['', 'x', p1, 'o', '', 'y', ''],
      ['x', p1, 'o', '', '', p2, ''],
      [p1, 'o', 'z', '', p2, '', ''],
      ['o', 'z', '', '', '', '', '']
    ] }

    let(:diagonals) { [
      ['x', 'x', 'x', 'x'],
      [p1, p1, p1, p1, ''],
      ['o', 'o', 'o', 'o', 'o', 'o'],
      ['', '', '', '', 'z', 'z'],
      ['y', 'y', '', '', ''],
      ['', p2, p2, '']
    ] }
    it 'returns a nested array with diagonals from right to left' do
      expect(board.diagonal_right(grid)).to match_array(diagonals)
    end
  end
end
