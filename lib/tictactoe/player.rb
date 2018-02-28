module Tictactoe
	class Player
		attr_reader :color, :name, :kind
		def initialize(input)
			@color = input.fetch(:color)
			@name = input.fetch(:name)
			@kind = input.fetch(:kind) 
		end
	end
end