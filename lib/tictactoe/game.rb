module Tictactoe
	class Game
		attr_reader :players, :board, :current_player, :other_player
		def initialize players, board = Board.new 
			@players = players
			@board= board
			@current_player, @other_player = players.shuffle
		end

		def play
      		puts "#{current_player.name} has randomly been selected as the first player"
      		while true
				board.formatted_grid
				puts ""
				puts solicit_move
				x, y = get_move
				cell = board.get_cell(x,y)
				value = cell.to_s.empty? ? "" : cell.value
				unless x.nil? || y.nil? || !value.empty?
					board.set_cell(x, y, current_player.color)
					if board.game_over
			  			puts game_over_message
			  			board.formatted_grid
			  			return
					else
			  			switch_players
					end
				else
					puts "Bad Play!!! Try again!"
					next
				end
			end
    	end

    	def computer_play level
    		puts "#{current_player.name} has randomly been selected as the first player"
    		while true
    			if current_player.kind == :comp
    				x,y = level == '1' ? get_easy_computer_move : get_hard_computer_move
    			else
					board.formatted_grid
					puts ""
					puts solicit_move
					x, y = get_move
				end
				cell = board.get_cell(x,y)
				value = cell.to_s.empty? ? "" : cell.value
				unless x.nil? || y.nil? || !value.empty?
					board.set_cell(x, y, current_player.color)
					if board.game_over
			  			puts game_over_message
			  			board.formatted_grid
			  			return
					else
			  			switch_players
					end
				else
					puts "Bad Play!!! Try again!"
					next
				end
			end
    	end

    	def computer_with_computer_play level
    		while !board.game_over
    			x,y = level == '1' ? get_easy_computer_move : get_hard_computer_move
				cell = board.get_cell(x,y)
				board.set_cell(x, y, current_player.color)
				if board.game_over
		  			puts game_over_message
		  			board.formatted_grid
		  			return
				else
		  			switch_players
				end
			end
    	end

		private

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def solicit_move
			"#{current_player.name}: Enter 1 to 9 option for your move: ('e' or 'exit' to quit)"
		end

		def get_move(human_move= gets.chomp)
			if human_move == "exit" || human_move == "e" 
				exit
			end
			move_to_cordinate(human_move)
		end

		def get_easy_computer_move
			move_to_cordinate(available_spaces.sample.to_s)
		end

		def get_hard_computer_move
			available_spaces.each do |option|
				x,y = move_to_cordinate(option.to_s)
				board.set_cell(x, y, current_player.color)
				if board.game_over
		  			board.set_cell(x,y, "")
			  		return move_to_cordinate(option.to_s)
			  	end
				board.set_cell(x,y, "")
			 end
			 available_spaces.each do |option|
				x,y = move_to_cordinate(option.to_s)
			  	board.set_cell(x,y, other_player.color)
			  	if board.game_over
			  		board.set_cell(x,y, "")
			  		return move_to_cordinate(option.to_s)
			  	end
			  	board.set_cell(x,y, "")
			end
			move_to_cordinate(available_spaces.sample.to_s)
		end

		def game_over_message
			return "#{current_player.name} won!" if board.game_over == :winner
			return "The game ended in a tie!" if board.game_over == :draw
		end	

		def available_spaces
			arr = []
			(1..9).each do |option|
				x,y = move_to_cordinate option.to_s
				if board.get_cell(x,y).value.empty?
					arr.push option
				end
			end
			arr
		end

		def move_to_cordinate human_move
			mapping = {
				'1' => [0,0],
				'2' => [0,1],
				'3' => [0,2],
				'4' => [1,0],
				'5' => [1,1],
				'6' => [1,2],
				'7' => [2,0],
				'8' => [2,1],
				'9' => [2,2]
			}
			mapping[human_move]
		end
	end
end