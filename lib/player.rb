# frozen_string_literal: true

require_relative 'display'

# Player attributes
class Player
  extend Display

  # prompts until name is valid
  def self.select_name(player_num, input = nil)
    prompt_name(player_num)
    input ||= gets.chomp
    until Player.valid_name?(input)
      error_name(player_num)
      input = gets.chomp
    end
    input
  end

  # match: any alphabet, space, length between 1-12
  def self.valid_name?(input)
    input.match?(/^[a-zA-Z ]{1,12}$/)
  end

  # prompts until color is valid. deletes token from token pool
  def self.select_token_color(player_name, tokens, input = nil)
    prompt_token(player_name, tokens)
    input ||= gets.chomp
    until tokens.include?(input.downcase)
      error_token(player_name)
      input = gets.chomp
    end
    input.downcase.to_sym
  end

  attr_accessor :name, :token

  def initialize
    @name = nil
    @token = nil
  end
end
