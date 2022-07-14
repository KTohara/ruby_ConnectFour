# frozen_string_literal: true

require_relative 'color'

# Display outputs
module Display
  # green column numbers on board display (main method: board.to_s)
  def self.display_col_nums
    (1..7).map { |num| num.to_s.green }.join(" #{VERT} ")
  end

  # borders for board display (main method: board.to_s)
  BOT_L  = "\u2559".blue # ╙
  BOT_R  = "\u255C".blue # ╜
  BOT_J  = "\u2534".blue # ┴
  BOT    = "\u2500".blue # ─
  L_JOIN = "\u255F".blue # ╟
  R_JOIN = "\u2562".blue # ╢
  A_JOIN = "\u253C".blue # ┼
  THIC   = "\u2551".blue # ║
  VERT   = "\u2502".blue # │
  SPACE  = ' ' * 3

  BORDER_TOP = THIC + ((SPACE + VERT) * 6) + SPACE + THIC
  DIVIDER = L_JOIN + (((BOT * 3) + A_JOIN) * 6) + (BOT * 3) + R_JOIN
  COL_NUMBERS = "#{THIC} " + display_col_nums + " #{THIC}"
  BORDER_BOTTOM = BOT_L + (((BOT * 3) + BOT_J) * 6) + (BOT * 3) + BOT_R

  # board display helper (main method: board.to_s)
  def display_rows(row)
    game_row = row.map { |type| tokens(type) }.join(" #{VERT} ")
    "#{THIC} " + game_row + " #{THIC}"
  end

  # token types for display_rows (main method: board.to_s)
  def tokens(type)
    {
      :red => "\u25CF".red,       # ●
      :blue => "\u25CF".blue,     # ●
      :yellow => "\u25CF".yellow, # ●
      :green => "\u25CF".green,   # ●
      :black => "\u25CF".black,   # ●
      '' => "\u25CC"              # ◌
    }[type]
  end

  # main render script for game
  def render(board)
    system('clear')
    display_banner
    puts board
  end

  # intro banner
  def display_banner
    puts <<~BANNER

      ╒═══════════════════════════════════════════════╕
      │░█▀▀░█▀█░█▀▄░█▀▄░█▀▀░█▀▀░▀█▀░░░█▀▀░█▀█░█░█░█▀▄░│
      │░█░░░█░█░█░█░█░█░█▀▀░█░░░░█░░◆░█▀▀░█░█░█░█░█▀▄░│
      │░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░░░░▀░░░▀▀▀░▀▀▀░▀░▀░│
      ╘═══════════════════════════════════════════════╛

    BANNER
      .blue
  end

  # intro to game
  def display_intro
    puts <<~INTRO
      Welcome to Connect Four!

      * Players must connect four of the same colored tokens in a row to win.
      * Only one piece is played at a time.
      * The game ends when there is a four-in-a-row or a stalemate.

    INTRO
      .blue
  end

  # for Player.select_token_color
  def display_tokens(tokens)
    tokens.map do |token|
      token = token.capitalize
      case token
      when 'Red' then token.red
      when 'Blue' then token.blue
      when 'Yellow' then token.yellow
      when 'Green' then token.green
      when 'Black' then token.black
      end
    end
  end

  # game messages
  def prompt_name(player_num)
    puts "Select a name, Player #{player_num} (maximumn 12 characters):\n"
  end

  def error_name(player_num)
    puts "Name is invalid, Player #{player_num}\n"
  end

  def prompt_token(player_name, tokens)
    puts "Select a token, #{player_name}:\n\n#{display_tokens(tokens).join(' ')}"
  end

  def error_token(player_name)
    puts "Token is invalid, #{player_name}"
  end

  def prompt_move(player_name)
    puts "Select a column, #{player_name}"
  end

  def error_move(player_name)
    puts "#{player_name}, column is not a valid move!"
  end

  def prompt_replay
    puts "Play again?\n(y)es / (n)o"
  end

  def error_replay
    puts "Not a valid choice. Play again?\n(y)es / (n)o"
  end

  def winner_message(player_name)
    puts "#{player_name} is the winner!".bold
  end

  def draw_message
    puts 'Game is a draw!'.bold
  end

  def thanks_message
    puts 'Thanks for playing!'.bold
  end
end
