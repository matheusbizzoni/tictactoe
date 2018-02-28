module Tictactoe
	RSpec.describe Game do
		subject { Game.new([pedro,paula]) }
		TestStruct = Struct.new(:value)
		let(:x_cell) { TestStruct.new('X') }
		let(:o_cell) { TestStruct.new('O') }
		let(:empty){ TestStruct.new("") }
		let(:pedro) { Player.new({ color: 'X', name: 'Pedro', kind: :hum }) }
		let(:paula) { Player.new({ color: 'O', name: 'Paula', kind: :hum }) }
		let(:computer) { Player.new({ color: 'O', name: 'Computer', kind: :comp }) }

		context 'initialize' do
			it 'randomly select current_player' do
				allow_any_instance_of(Array).to receive(:shuffle).and_return [paula,pedro]
				expect(subject.current_player).to eq paula
			end
			it 'randomly select other_player' do
				allow_any_instance_of(Array).to receive(:shuffle).and_return [paula,pedro]
				expect(subject.other_player).to eq pedro
			end
		end

		context '#private methods' do

			
			context '#switch_players' do
			it 'will switch current_player with other_player' do 
				current_player = subject.current_player
				subject.send(:switch_players)
				expect(subject.other_player).to eq current_player
			end
			it 'will switch other_player with current_player' do 
				other_player = subject.other_player
				subject.send(:switch_players)
				expect(subject.current_player).to eq other_player
			end
			end

			context '#solicit_move' do
				it 'solicit player to make a move' do
					allow(subject).to receive(:current_player).and_return paula
					expect(subject.send(:solicit_move)).to eq "Paula: Enter 1 to 9 option for your move: ('e' or 'exit' to quit)"
				end
			end

			context '#get_move' do
				it 'converts human_move of 1 to [0,0]' do
					expect(subject.send(:get_move, '1')).to eq [0,0]
				end
			end

			context '#available_spaces' do
		
				it 'returns all eigth empty cells on grid' do
					grid = [
						[empty, empty, empty],
						[empty, empty, empty],
						[empty, empty, x_cell]
					]
					board = Board.new(grid: grid)
					game = Game.new([pedro,paula], board)
					expect(game.send(:available_spaces).size).to eq 8
				end

				it 'returns only one empty cell on grid' do
					grid = [
						[empty, o_cell, o_cell],
						[o_cell, x_cell, o_cell],
						[o_cell, x_cell, x_cell]
					]
					board = Board.new(grid: grid)
					game = Game.new([pedro,paula], board)
					expect(game.send(:available_spaces).size).to eq 1
				end
			end

			context '#get_hard_computer_move' do
				it 'returns cordinate that will not allow user to win' do
					grid = Array.new(3) { Array.new(3) { TestStruct.new("") } }
					grid[0][2] = o_cell
					grid[1][2] = o_cell
					grid[2][1] = x_cell
					grid[2][2] = x_cell
					board = Board.new(grid: grid)
					game = Game.new([pedro,computer], board)
					expect(game.send(:get_hard_computer_move)).to eq [2,0]
				end

				it 'returns that computer to won' do
					grid = Array.new(3) { Array.new(3) { TestStruct.new("") } }
					grid[0][2] = x_cell
					grid[1][2] = x_cell
					grid[2][1] = o_cell
					grid[2][2] = o_cell
					board = Board.new(grid: grid)
					game = Game.new([pedro,computer], board)
					allow(game).to receive(:current_player).and_return(computer)
					expect(game.send(:get_hard_computer_move)).to eq [2,0]
				end
			end

			context '#get_easy_computer_move' do
				it 'return random cordinate' do
					allow_any_instance_of(Array).to receive(:sample).and_return 1
					expect(subject.send(:get_easy_computer_move)).to eq [0,0]
				end 
			end

			context '#game_over_message' do
				it 'return winner message' do
					allow(subject).to receive(:current_player).and_return paula
					allow(subject.board).to receive(:game_over).and_return :winner

					expect(subject.send(:game_over_message)).to eq "Paula won!"
				end

				it 'return draw message' do
					allow(subject.board).to receive(:game_over).and_return :draw

					expect(subject.send(:game_over_message)).to eq  "The game ended in a tie!"
				end
			end
		end		
	end
end