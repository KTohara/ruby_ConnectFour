# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display'

# Connect Four game loops/play order
class Game
  include Display

  attr_reader :board, :players, :current_player

  def initialize
    @board = Board.new
    @players = [Player.new, Player.new]
    @current_player = players.sample
  end

  def play
    display_banner
    # display_intro
    input_player_data
    # game_loop
    # game_result
    # display_game_end
  end

  def input_player_data
    players.each_with_index do |player, player_num|
      player.name = Player.select_name(player_num + 1)
      player.token = Player.select_token_color(player)
    end
  end

  def game_loop
    until board.game_over?
      # display_board(board)
      col = player_move
      # board.add_token(col, current_player.token)
      # switch_player
    end
  end

  def player_move
    prompt_move(current_player.name)
    input = gets.chomp
    until board.valid_move?(input)
      error_move(current_player.name)
      input = gets.chomp
    end
    input.to_i
  end
end
