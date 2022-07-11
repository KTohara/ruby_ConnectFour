# frozen_string_literal: true

require 'board'

describe Board do
  subject(:board) { described_class.new }
  let(:p1) { :black }
  let(:p2) { :red }

  describe '#initialize' do
    it 'creates a nested array with 42 elements' do
      board_size = subject.grid.flatten.length
      expect(board_size).to eq(42)
    end

    it 'should all be empty strings' do
      board_cells = subject.grid.flatten
      expect(board_cells).to all(be_empty)
      expect(board_cells).to all(be_a(String))
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
        allow(board).to receive(:four_in_a_row?).once.and_return(true)
        expect(board).to be_win
      end
    end

    context 'when there is a column four-in-a-row' do
      it 'returns true' do
        allow(board).to receive(:four_in_a_row?).twice.and_return(false, true)
        expect(board).to be_win
      end
    end

    context 'when there is a diagonal four-in-a-row' do
      it 'returns true' do
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

    context 'when there is NO row with four-in-a-row' do
      let(:grid) { [
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '']
      ] }

      it 'returns false' do
        expect(board.four_in_a_row?(grid)).to_not be true
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

    it 'returns a nested array with all diagonals from rleft to right' do
      
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
