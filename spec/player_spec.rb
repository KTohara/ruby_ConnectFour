# frozen_string_literal: true

require 'player'

describe Player do
  subject(:player_class) { described_class }

  describe '.valid_name?' do
    context 'when a valid name is given' do
      it 'returns true' do
        input_name = 'hello'
        expect(player_class.valid_name?(input_name)).to be true
      end
    end

    context 'when a name contains a space' do
      it 'returns true' do
        input_name = 'hello world'
        expect(player_class.valid_name?(input_name)).to be true
      end
    end

    context 'when the input has a number' do
      it 'returns false' do
        input_name = '12345hello'
        expect(player_class.valid_name?(input_name)).to be false
      end
    end

    context 'when the input is longer than 12 letters' do
      it 'returns false' do
        input_name = 'hello world my name is rhubarb the cat'
        expect(player_class.valid_name?(input_name)).to be false
      end
    end

    context 'when the input contains special characters' do
      it 'returns false' do
        input_name = 'ⓡⓗⓤⓑⓐⓡⓑ'
        expect(player_class.valid_name?(input_name)).to be false
        input_name = 'my_name'
        expect(player_class.valid_name?(input_name)).to be false
        input_name = 'my n@me'
        expect(player_class.valid_name?(input_name)).to be false
      end
    end
  end

  describe '.select_name' do
    let(:player_num) { 1 }
    let(:valid_name) { 'Rhubarb' }
    let(:invalid_name) { 'ⓡⓗⓤⓑⓐⓡⓑ' }

    before { allow(player_class).to receive(:prompt_name).once }

    context 'when a valid name is given' do
      before { allow(player_class).to receive(:valid_name?).and_return(true) }

      it 'should not produce an error message' do
        expect(player_class).not_to receive(:error_name)
        player_class.select_name(player_num, valid_name)
      end

      it 'should return the valid name' do
        expect(player_class.select_name(player_num, 'Rhubarb')).to eq('Rhubarb')
      end
    end

    context 'when the name input is invalid, then valid' do
      before { allow(player_class).to receive(:valid_name?).and_return(false, true) }

      it 'should output an error message once' do
        expect(player_class).to receive(:error_name).once
        player_class.select_name(player_num, invalid_name)
      end

      it 'should return a valid name when the second input is valid' do
        allow(player_class).to receive(:error_name).once
        allow(player_class).to receive(:gets).and_return(valid_name)
        expect(player_class.select_name(player_num)).to eq(valid_name)
      end
    end
  end

  describe '.select_token_color' do
    let(:player_name) { 'Rhubarb' }
    let(:tokens) { %w[red blue yellow green black] }

    context 'when a valid token color is picked' do
      before { allow(player_class).to receive(:prompt_token) }

      it 'should not receive an error' do
        expect(player_class).not_to receive(:error_token)
        player_class.select_token_color(player_name, tokens, 'red')
      end

      it 'should return valid token symbol' do
        allow(tokens).to receive(:include?).and_return(true)
        expect(player_class.select_token_color(player_name, tokens, 'red')).to eq(:red)
      end
    end

    context 'when the token input is invalid, then valid' do
      before do
        allow(player_class).to receive(:prompt_token).once
        allow(tokens).to receive(:include?).and_return(false, true)
      end

      it 'should output an error message once' do
        expect(player_class).to receive(:error_token).once
        player_class.select_token_color(player_name, tokens, 'donkey')
      end

      it 'should return a valid token symbol when the second input is valid' do
        allow(player_class).to receive(:error_token).once
        allow(player_class).to receive(:gets).once.and_return('red')
        expect(player_class.select_token_color(player_name, tokens, 'donkey')).to eq(:red)
      end
    end
  end
end
