require 'player'

describe Player do
  describe '#valid_name?' do
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
end