require_relative 'board'
require_relative 'game'
require_relative 'player'

def run
  game = Game.new
  game.play
  repeat_game
end

def replay_game
  prompt_replay
  input = gets.chomp.downcase
  until %(y n).include?(input)
    error_replay
    input = gets.chomp.downcase
  end
  input == 'y' ? play : thanks_message
end

run if $PROGRAM_NAME == __FILE__