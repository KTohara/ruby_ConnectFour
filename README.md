# Ruby Connect Four #
Connect Four project from [Odin Project](https://www.theodinproject.com/lessons/ruby-connect-four)

## Game ##
Win by being the first player to connect four of the same colored tokens in a row (either vertically, horizontally, or diagonally).

  - Players alternate turns, and only one token can be dropped in each turn.
  - On a turn, player drops their colored token from the top into any of the seven slots. 
  - The game ends when there is a four-in-a-row or a stalemate.

### Play ###
Head to [repl.it](https://replit.com/@KenTohara/rubyConnectFour)!

Press the green run button at the top of the page.

[![Run on Repl.it](https://repl.it/badge/github/KTohara/ruby_ConnectFour)](https://replit.com/@KenTohara/rubyConnectFour)

### Thoughts ###
This project was completed using TDD; to practice being comfortable with the idea of writing tests, implementing it as code, and then refactoring to make it better.

Input and output testing was difficult to implement. As was the learning process of mocking and stubbing. I learned a bit more about keeping methods to be simple and try to have it only accomplish one thing.

I am still learning what the scope of testing should be. I kept methods public just to have a better understanding of how to work with the syntax. There is definitely a lot more that could have been done better in terms of keeping things DRY, and I probably missed a few edge cases!