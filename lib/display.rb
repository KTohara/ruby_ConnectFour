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

  def message(type, *args)
    {
      prompt_name: "Select a name: #{args.first}\n", # player_num
      error_name: "Name is invalid, Player #{args.first}\n", # player_name
      prompt_token: "Select a token, #{args.first}:\n\n#{args.last.map(&:capitalize).join(' ')}", # player_name, tokens
      error_token: "Token is invalid, #{args.first}" # player_name
    }[type]
  end
end
