class Player
  attr_reader :name, :token

  def initialize
    @name = nil
    @token = nil
  end

  def self.valid_name?(input)
    input.match?(/^[a-zA-Z ]{1,12}$/)
  end
end