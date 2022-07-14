# frozen_string_literal: true

require 'game'

describe Game do
  subject(:game) { described_class.new }
  let(:player) { class_double(Player).as_stubbed_const }
  let(:player_one) { instance_double(Player, 'Player One', name: 'Rhubarb', token: :red) }
  let(:player_two) { instance_double(Player, 'Player Two', name: 'Muenster', token: :black) }
  let(:board) { instance_double(Board) }

  before do
    game.instance_variable_set(:@board, board)
    game.instance_variable_set(:@players, [player_one, player_two])
    game.instance_variable_set(:@current_player, player_one)
  end

  describe '#input_player_data' do
    let(:p1_no_data) { instance_double(Player, 'Player One') }
    let(:p2_no_data) { instance_double(Player, 'Player Two') }

    before do
      game.instance_variable_set(:@players, [p1_no_data, p2_no_data])
      allow(p1_no_data).to receive(:name)
      allow(p2_no_data).to receive(:name)
      allow(p1_no_data).to receive(:name=)
      allow(p2_no_data).to receive(:name=)
      allow(p1_no_data).to receive(:token=)
      allow(p2_no_data).to receive(:token=)
      allow(player).to receive(:select_name).and_return('Rhubarb', 'Muenster')
      allow(player).to receive(:select_token_color).and_return(:red, :black)
    end

    after { game.input_player_data }

    context 'when a game has two players' do
      it 'should send #select_name to Player' do
        expect(player).to receive(:select_name).twice
      end

      it 'should send #select_token_color to Player' do
        expect(player).to receive(:select_token_color).twice
      end

      it 'sets the name and token for player one' do
        expect(p1_no_data).to receive(:name=).and_return('Rhubarb')
        expect(p1_no_data).to receive(:token=).and_return(:red)
      end

      it 'sets the name and token for player two' do
        expect(p2_no_data).to receive(:name=).and_return('Muenster')
        expect(p2_no_data).to receive(:token=).and_return(:black)
      end
    end
  end

  describe '#game_loop' do
    before do
      allow(game).to receive(:render)
      allow(game).to receive(:player_move)
      allow(board).to receive(:add_token)
    end

    context 'when the game loops once (game over in 1 turn)' do
      before do
        allow(board).to receive(:game_over?).and_return(true)
      end

      after { game.game_loop }

      it 'should ask player for a move' do
        expect(game).to receive(:player_move).once
      end

      it 'should send #add_token to board' do
        expect(board).to receive(:add_token).once
      end

      it 'should send #game_over? to board' do
        expect(board).to receive(:game_over?).once
      end

      it 'should not switch players' do
        expect(game).not_to receive(:switch_player)
      end
    end

    context 'when the game loops twice (game over in 2 turns)' do
      before do
        allow(board).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:switch_player)
      end

      after { game.game_loop }

      it 'should ask player for a move' do
        expect(game).to receive(:player_move).twice
      end

      it 'should send #add_token to board' do
        expect(board).to receive(:add_token).twice
      end

      it 'should send #game_over? to board' do
        expect(board).to receive(:game_over?).twice
      end

      it 'should switch players once' do
        expect(game).to receive(:switch_player).once
      end
    end
  end

  describe '#player_move' do
    before { allow(game).to receive(:prompt_move) }

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

  describe '#switch_player' do
    context 'when the current player is player one' do
      before { game.switch_player }

      it 'should switch the current player to player two' do
        expect(game.current_player).to eq(player_two)
      end

      it 'should not set current player to player one' do
        expect(game.current_player).to_not eq(player_one)
      end
    end
  end

  describe '#game_result' do
    after { game.game_result }

    it 'should return a winner message if there is a winner' do
      allow(board).to receive(:win?).and_return(true)
      expect(game).to receive(:winner_message).once
      expect(game).not_to receive(:draw_message)
    end

    it 'should return a draw message if there is no winner' do
      allow(board).to receive(:win?).and_return(false)
      expect(game).not_to receive(:winner_message)
      expect(game).to receive(:draw_message).once
    end
  end
end
