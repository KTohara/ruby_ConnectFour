# frozen_string_literal: true

require 'player'

describe Player do
  describe '.valid_name?' do
    context 'when a valid name is given' do
      it 'returns true' do
        input_name = 'hello'
        expect(Player.valid_name?(input_name)).to be true
      end
    end

    context 'when a name contains a space' do
      it 'returns true' do
        input_name = 'hello world'
        expect(Player.valid_name?(input_name)).to be true
      end
    end

    context 'when the input has a number' do
      it 'returns false' do
        input_name = '12345hello'
        expect(Player.valid_name?(input_name)).to be false
      end
    end

    context 'when the input is longer than 12 letters' do
      it 'returns false' do
        input_name = 'hello world my name is rhubarb the cat'
        expect(Player.valid_name?(input_name)).to be false
      end
    end

    context 'when the input contains special characters' do
      it 'returns false' do
        input_name = 'ⓡⓗⓤⓑⓐⓡⓑ'
        expect(Player.valid_name?(input_name)).to be false
        input_name = 'my_name'
        expect(Player.valid_name?(input_name)).to be false
        input_name = 'my n@me'
        expect(Player.valid_name?(input_name)).to be false
      end
    end
  end

  describe '.select_name' do
    let(:player_num) { 1 }
    let(:valid_name) { 'Rhubarb' }
    let(:invalid_name) { 'ⓡⓗⓤⓑⓐⓡⓑ' }

    context 'when a valid name is given' do
      before do
        allow(Player).to receive(:prompt_name).once
        allow(Player).to receive(:gets).and_return(valid_name)
        allow(Player).to receive(:valid_name?).and_return(true)
      end

      it 'should not produce an error message' do
        expect(Player).not_to receive(:error_name)
        Player.select_name(player_num)
      end

      it 'should return the valid name' do
        expect(Player.select_name(player_num)).to eq(valid_name)
      end
    end

    context 'when a invalid name is given twice, then a valid name is given' do
      before do
        # allow(Player).to receive(:puts)
        allow(Player).to receive(:prompt_name).once
        allow(Player).to receive(:valid_name?).and_return(false, false, true)
        allow(Player).to receive(:gets).and_return(invalid_name, invalid_name, valid_name)
      end

      it 'should output an error message twice' do
        expect(Player).to receive(:error_name).twice
        Player.select_name(player_num)
      end

      it 'should return a valid name' do
        allow(Player).to receive(:error_name)
        expect(Player.select_name(player_num)).to eq(valid_name)
      end
    end
  end

  describe '.select_token_color' do
    let(:player_name) { 'Rhubarb' }

    context 'when a valid token color is picked' do
      let(:tokens) { Player.instance_variable_set(:@tokens, %w[red blue yellow green black]) }

      before do
        allow(Player).to receive(:prompt_token)
        allow(Player).to receive(:gets).and_return('red')
      end

      it 'should not receive an error' do
        expect(Player).not_to receive(:error_token)
        Player.select_token_color(player_name)
      end

      it 'should return valid token symbol' do
        allow(tokens).to receive(:include?).and_return(true)
        expect(Player.select_token_color(player_name)).to eq(:red)
      end

      it 'should delete the token from the token pool' do
        allow(tokens).to receive(:include?).and_return(true)
        Player.select_token_color(player_name)
        expect(tokens).to eq(%w[blue yellow green black])
      end
    end

    context 'when a invalid token color is picked once, then a valid token' do
      let(:tokens) { Player.instance_variable_set(:@tokens, %w[red blue yellow green black]) }

      before do
        # allow(Player).to receive(:puts)
        allow(Player).to receive(:prompt_token).once
        allow(Player).to receive(:gets).twice.and_return('donkey', 'red')
        allow(tokens).to receive(:include?).and_return(false, true)
      end

      it 'should output an error message once' do
        expect(Player).to receive(:error_token).once
        Player.select_token_color(player_name)
      end

      it 'should return a valid token symbol' do
        allow(Player).to receive(:error_token).once
        expect(Player.select_token_color(player_name)).to eq(:red)
      end

      it 'should delete the token from the token pool' do
        allow(Player).to receive(:error_token).once
        Player.select_token_color(player_name)
        expect(tokens).to eq(%w[blue yellow green black])
      end
    end
  end
end
