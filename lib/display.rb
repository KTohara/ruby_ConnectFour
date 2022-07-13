# frozen_string_literal: true

require_relative 'color'

# Display outputs
module Display
  # grid borders
  BOT_L  = "\u2559".blue # ╙
  BOT_R  = "\u255C".blue # ╜
  BOT_J  = "\u2534".blue # ┴
  BOT    = "\u2500".blue # ─
  THIC   = "\u2551".blue # ║
  VERT   = "\u2502".blue # │
  SPACE  = ' ' * 3

  BORDER_TOP = THIC + ((SPACE + VERT) * 6) + SPACE + THIC
  BORDER_BOTTOM = BOT_L + (((BOT * 3) + BOT_J) * 6) + (BOT * 3) + BOT_R

  # token types
  def tokens(type)
    {
      :red => "\u25CF".red,       # ●
      :blue => "\u25CF".blue,     # ●
      :yellow => "\u25CF".yellow, # ●
      :green => "\u25CF".green,   # ●
      :black => "\u25CF".black,   # ●
      '' => "\u25CC" # ◌
    }[type]
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

  # board display helper (Board.to_s)
  def display_rows(row)
    game_row = row.map { |type| tokens(type) }.join(" #{VERT} ")
    "#{THIC} " + game_row + " #{THIC}"
  end

  # game messages
  def prompt_name(player_num)
    puts "Select a name, Player #{player_num}:\n"
  end

  def error_name(player_num)
    puts "Name is invalid, Player #{player_num}\n"
  end

  def prompt_token(player_name, tokens)
    puts "Select a token, #{player_name}:\n\n#{tokens.map(&:capitalize).join(' ')}"
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
end
