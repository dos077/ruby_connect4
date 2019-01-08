require "./lib/game.rb"

class GameController
    def initialize
        puts "Welcome to a game of Connect 4. The rules are same with the classic, with a 6 height by 7 wide canvas."
        puts "Who is the first player?"
        player1 = gets.chomp
        puts "And who is player number two?"
        player2 = gets.chomp
        @game = Connect4.new(player1, player2)
        play
    end

    def play
        player_turn = 1
        until @game.victory?
            display
            move = nil
            player = (player_turn == 1)? @game.player1 : @game.player2
            until move
                puts "#{player} please tell me which column you wish to stack."
                move = gets.chomp.to_i - 1
                unless @game.move_legal?(move)
                    move = nil
                    puts "That's not a column on the board."
                else
                    @game.move(move, player_turn)
                    player_turn = (player_turn==1)? 2 : 1
                end
            end
        end
        game_over
    end

    def display
        system "clear"
        cells = @game.output
        screen = ""
        
        6.times do |i|
            screen << "+---+---+---+---+---+---+---+\n|"
            7.times do |j|
                n = 41 - ( 7 * i ) - ( 6 - j )
                screen << " #{cells[n]} |"
            end
            screen << "\n"
        end
        screen << "+---+---+---+---+---+---+---+\n| 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n+---+---+---+---+---+---+---+\n"
        puts screen
    end

    def game_over
        display
        game_result = @game.victory?
        if game_result == 3
            puts "Game Over, It's a Draw."
        else
            name = (game_result==1)? @game.player1 : @game.player2
            puts "Congradulation #{name}, You Yon!"
        end
    end
end

GameController.new