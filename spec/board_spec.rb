require 'board'

describe Board do
  subject(:board) { described_class.new }

  describe '#initialize' do
    it 'creates a nested array with 42 elements' do
      board_size = subject.board.flatten.length
      expect(board_size).to eq(42)
    end

    it 'should all be empty strings' do
      board_cells = subject.board.flatten
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
    context 'when there is a diagonal connect four' do
      it 'returns true' do
        allow(board).to receive(:diag_connect?).and_return(true)
        expect(board).to be_win
      end
    end

    context 'when there is a row connect four' do
      it 'returns true' do
        allow(board).to receive(:row_connect?).and_return(true)
        expect(board).to be_win
      end
    end

    context 'when there is a collumn connect four' do
      it 'returns true' do
        allow(board).to receive(:col_connect?).and_return(true)
        expect(board).to be_win
      end
    end

    context 'when there is no #connect_four?' do
      it 'returns false' do
        allow(board).to receive(:diag_connect?).and_return(false)
        allow(board).to receive(:row_connect?).and_return(false)
        allow(board).to receive(:col_connect?).and_return(false)
        expect(board).to_not be_win
      end
    end
  end

  describe '#diag_connect?' do
    context 'when there is a diagonal connect four' do
      before {}
      it 'returns true' do

      end
    end
  end
end