# frozen_string_literal: true

require 'game'

describe Game do
  subject(:game) { described_class.new }
  let(:player_one) { instance_double(Player) }
  let(:player_two) { instance_double(Player) }
  let(:board) { instance_double(Board) }

  before do
    game.instance_variable_set(:@board, board)
    game.instance_variable_set(:@players, [player_one, player_two])
    #   allow($stdout).to receive(:puts)
    #   allow($stdout).to receive(:write)
  end

  describe '#input_player_data' do
    before do
      allow(player_one).to receive(:name=)
      allow(player_two).to receive(:name=)
      allow(player_one).to receive(:token=)
      allow(player_two).to receive(:token=)
      allow(Player).to receive(:select_name).and_return('Rhubarb', 'Muenster')
      allow(Player).to receive(:select_token_color).and_return(:red, :black)
    end

    context 'when a game has two players' do
      let(:method) { game.input_player_data }

      it 'should call Player.select_name' do
        expect(Player).to receive(:select_name).twice
        game.input_player_data
      end

      it 'should call Player.select_token_color' do
        expect(Player).to receive(:select_token_color).twice
        game.input_player_data
      end

      it 'sets the name and token for player one' do
        expect(player_one).to receive(:name=).and_return('Rhubarb')
        expect(player_one).to receive(:token=).and_return(:red)
        game.input_player_data
      end

      it 'sets the name and token for player two' do
        expect(player_two).to receive(:name=).and_return('Muenster')
        expect(player_two).to receive(:token=).and_return(:black)
        game.input_player_data
      end
    end
  end

  describe '#player_move' do
    before do 
      allow(player_one).to receive(:name)
      allow(player_two).to receive(:name)
      allow(game).to receive(:prompt_move)
    end

    context 'when the input is a valid move' do
      before do
        allow(game).to receive(:gets).and_return('7')
        allow(board).to receive(:valid_move?).and_return(true)
      end

      it 'does not show any errors' do
        expect(game).not_to receive(:error_move)
        game.player_move
      end

      it 'sends #valid_move? to Board' do
        expect(board).to receive(:valid_move?).once
        game.player_move
      end

      it 'returns the correct input as an integer' do
        expect(game.player_move).to eq(7)
      end
    end

    context 'when the input is a invalid move twice, and then valid' do
      before do
        allow(game).to receive(:gets).and_return('hello!', '20', '3')
        allow(board).to receive(:valid_move?).and_return(false, false, true)
      end

      it 'shows an error twice' do
        expect(game).to receive(:error_move).twice
        game.player_move
      end

      it 'returns the input as an integer' do
        allow(game).to receive(:error_move).twice
        expect(game.player_move).to eq(3)
      end
    end
  end
end
