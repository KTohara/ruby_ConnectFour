# frozen_string_literal: true

require_relative 'display'

# Player attributes
class Player
  extend Display

  class << self
    attr_reader :tokens, :taken_tokens
  end

  MAX_NAME_LENGTH = 12

  @tokens = %w[red blue yellow green black]

  def self.select_name(player_num)
    prompt_name(player_num)
    name = gets.chomp
    until Player.valid_name?(name)
      error_name(player_num)
      name = gets.chomp
    end
    name
  end

  def self.valid_name?(input)
    input.match?(/^[a-zA-Z ]{1,#{MAX_NAME_LENGTH}}$/)
  end

  def self.select_token_color(player_name)
    prompt_token(player_name, tokens)
    token = gets.chomp
    until tokens.include?(token.downcase)
      error_token(player_name)
      token = gets.chomp
    end
    tokens.delete(token)
    token.downcase.to_sym
  end

  attr_accessor :name, :token

  def initialize
    @name = nil
    @token = nil
  end
end
