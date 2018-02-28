module Tictactoe
	class Board
		DEFAULT_ARRAY = ["1","2","3","4","5","6","7","8","9"]
		attr_reader :grid
		def initialize input = {} 
			@grid = input.fetch(:grid, default_grid)
		end

		def get_cell x,y
			x.nil? || y.nil? ? "" : grid[x][y] 
		end

		def set_cell x,y,value
			get_cell(x,y).value = value
		end

		def game_over
			return :winner if winner?
			return :draw if draw?
			false
		end

		def formatted_grid 
			i = 0
			grid.each do |row|
				puts row.map { |cell| i+=1;  cell.value.empty? ? i : cell.value }.join(" ") 
			end
		end

		private

		def default_grid 
			Array.new(3) { Array.new(3) { Cell.new } }
		end

		def draw?
			grid.flatten.map { |cell| cell.value }.none_empty?
		end


		def winner?
			winning_positions.each do |winning_position|
				next if winning_positions_values(winning_position).all_empty?
				return true if winning_positions_values(winning_position).all_same?
			end
			false
		end

		def winning_positions
			grid + grid.transpose + diagonals
		end

		def diagonals
			[
				[get_cell(0,0), get_cell(1,1), get_cell(2,2)],
				[get_cell(0,2), get_cell(1,1), get_cell(2,0)]
			]
		end

		def winning_positions_values(winning_position)
			winning_position.map { |cell| cell.value } 
		end
	end
end