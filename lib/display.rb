# frozen_string_literal: true

# Display outputs
module Display
  def banner
    puts <<~BANNER

      ╒═══════════════════════════════════════════════╕
      │░█▀▀░█▀█░█▀▄░█▀▄░█▀▀░█▀▀░▀█▀░░░█▀▀░█▀█░█░█░█▀▄░│
      │░█░░░█░█░█░█░█░█░█▀▀░█░░░░█░░◆░█▀▀░█░█░█░█░█▀▄░│
      │░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░░▀░░░░▀░░░▀▀▀░▀▀▀░▀░▀░│
      ╘═══════════════════════════════════════════════╛

    BANNER
  end

  def prompt_name(player_num)
    puts "Select a name: #{args.first}\n"
  end

  def error_name(player_num)
    puts "Name is invalid, Player #{args.first}\n"
  end

  def prompt_token(player_name, tokens)
    puts "Select a token, #{args.first}:\n\n#{args.last.map(&:capitalize).join(' ')}"
  end

  def error_token(player_name)
    puts "Token is invalid, #{args.first}"
  end
end
