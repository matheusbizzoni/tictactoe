require_relative "cell"
require_relative "player"
require_relative "board"
require_relative "core_extensions"
require_relative "game"
module Tictactoe
	class Application
		def initialize
			puts "Wellcome to tic tac toe"
			puts "Choose 1 for Player x Player mode, 2 for Player x Computer or 3 for Computer x Computer mode:"
			option = gets.chomp
			case option
			when "1"
				puts "Player1 Name:"
				player1_name = gets.chomp
				player1 = Tictactoe::Player.new({ color: 'X', name: player1_name, kind: :hum})
				puts "Player2 Name:"
				player2_name = gets.chomp
				player2 = Tictactoe::Player.new({ color: 'O', name: player2_name, kind: :hum})
				players = [player1, player2]
				Tictactoe::Game.new(players).play
			when "2"
				puts "Type 1 for easy and 2 for hard level:"
				level = gets.chomp
				if level != '1' || level != '2'
					puts "Invalid Option, lets play the hard way!"
					level = '2'
				end
				puts "Enter your name:"
				player1_name = gets.chomp
				player1 = Tictactoe::Player.new({ color: 'X', name: player1_name, kind: :hum})
				player2 = Tictactoe::Player.new({ color: 'O', name: "Computer", kind: :comp})
				players = [player1, player2]
				Tictactoe::Game.new(players).computer_play level
			when "3"
				puts "Type 1 for easy and 2 for hard level:"
				level = gets.chomp
				if level != '1' || level != '2'
					puts "Invalid Option, lets play the hard way!"
					level = '2'
				end
				player1 = Tictactoe::Player.new({ color: 'X', name: "Computer1", kind: :comp})
				player2 = Tictactoe::Player.new({ color: 'O', name: "Computer2", kind: :comp})
				players = [player1, player2]
				Tictactoe::Game.new(players).computer_with_computer_play level
			else
				puts "Invalid Option"
				exit
			end
		end

		Tictactoe::Application.new()
	end
end