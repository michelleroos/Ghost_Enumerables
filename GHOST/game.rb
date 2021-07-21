
require_relative "./player.rb"

class Game

    attr_reader :current_player, :previous_player

    def initialize
        @player_1 = Player.new("Robby")
        @player_2 = Player.new("Michelle")
        @current_player = @player_1
        @previous_player = @player_2
        @fragment = ""
        @dictionary = ['cat', 'dog', 'animal']
        @losses = {@player_1 => 0, @player_2 => 0}
    end

    def next_player!
        @current_player, @previous_player = @previous_player, @current_player
    end

    def take_turn
        test_value = " "
        until valid_play?(test_value)
            puts "#{@current_player.name}, please enter a valid character:"
            input = @current_player.guess # "S"
            test_value = @fragment + input
        end
            puts "The fragment is #{@fragment += input}"
    end

    def valid_play?(string)
        @dictionary.any? { |ele| ele.start_with?(string) }
    end

    def record(player)
        "GHOST"[0..@losses[player]]
    end

    def display_standings
        
    end

    def run 

    end


    def play_round
        puts "Please start the game by entering a character."
        until @dictionary.include?(@fragment)
            take_turn
            next_player!
        end
        puts "Sorry #{@previous_player.name}, you have lost."
    end

end