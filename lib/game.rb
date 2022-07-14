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
    @current_player = players.first
  end

  # main loop script
  def play
    display_banner
    display_intro
    input_player_data
    game_loop
    game_result
    replay_game
  end

  # sets each player's name and token
  def input_player_data(tokens = %w[red blue yellow green black])
    players.each_with_index do |player, player_num|
      name = Player.select_name(player_num + 1)
      player.name = name
      token = Player.select_token_color(player.name, tokens)
      player.token = token
      tokens.delete(token.to_s)
    end
  end

  # checks for #game_over every loop iteration - breaks if game over
  # loop: get a move, places a token, switches player
  def game_loop
    loop do
      render(board)
      col = player_move
      board.add_token(col, current_player.token)
      render(board)
      break if board.game_over?

      switch_player
    end
  end

  # prompts until input is valid move
  def player_move
    prompt_move(current_player.name)
    input = gets.chomp
    until board.valid_move?(input)
      error_move(current_player.name)
      input = gets.chomp
    end
    input.to_i
  end

  # rotates through @players
  def switch_player
    @current_player = current_player == players.first ? players.last : players.first
  end

  # if game is won, output winner message, otherwise output draw message
  def game_result
    board.win? ? winner_message(current_player.name) : draw_message
  end

  # prompt until y or n, starts new game if 'y'
  def replay_game
    prompt_replay
    input = gets.chomp
    until %(y n).include?(input)
      error_replay
      input = gets.chomp
    end
    input == 'y' ? Game.new.play : thanks_message
  end
end

Game.new.play if $PROGRAM_NAME == __FILE__
