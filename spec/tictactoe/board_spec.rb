module Tictactoe
	RSpec.describe Board do
		subject { Board.new }
		context '#initialize' do 
			it 'initializes the board with a grid' do
				expect { Board.new(grid: 'grid') }.not_to raise_error
			end

			it 'sets the grid with three rows by default' do
				expect(subject.grid.size).to eq 3
			end

			it 'creates three things in each row by default' do
				subject.grid.each do |row|
					expect(row.size).to eq 3
				end
			end
		end

		describe '#struct tests' do

			before :all do 
				TestStruct = Struct.new(:value)
				grid = [[TestStruct.new('test'),'',''], Array.new(3), Array.new(3)]
				@board = Board.new(grid: grid)
			end

			context '#get_cell' do
				it 'returns the cell based on cordinate x,y' do
					grid = [ Array.new(3), ['','','test'], Array.new(3) ]
					board = Board.new(grid: grid)
					expect(board.get_cell(1,2)).to eq 'test'
				end
			end

			context '#set_cell' do
				it 'does not raise error when calling set_cell method' do
					expect {@board.set_cell(0,0, 'new_value')}.not_to raise_error
				end

				it 'updates the value of the cell ' do
					@board.set_cell(0,0, 'new_value')
					expect(@board.get_cell(0,0).value).to eq 'new_value'
				end
			end	

			context '#game_over' do
				let(:x_cell) { TestStruct.new('X') }
				let(:o_cell) { TestStruct.new('0') }
				let(:empty){ TestStruct.new(nil) }

				it 'returns :winner if winner is true' do
					allow(subject).to receive(:winner?).and_return true
					expect(subject.game_over).to eq :winner
				end

				it 'returns :draw if winner is false and draw is true' do
					allow(subject).to receive(:winner?).and_return false
					allow(subject).to receive(:draw?).and_return true
					expect(subject.game_over).to eq :draw
				end

				it 'returns false if winner is false and draw is false' do
					allow(subject).to receive(:winner?).and_return false
					allow(subject).to receive(:draw?).and_return false
					expect(subject.game_over).to eq false
				end

				it 'returns winner when column has all same objects' do
					grid = [
						[x_cell, x_cell, empty],
						[o_cell, x_cell, o_cell],
						[o_cell, x_cell, empty]
					]
					board = Board.new(grid: grid)
					expect(board.game_over).to eq :winner
				end


				it 'returns winner when line has all same objects' do
					grid = [
						[x_cell, x_cell, empty],
						[o_cell, o_cell, o_cell],
						[empty, o_cell, x_cell]
					]
					board = Board.new(grid: grid)
					expect(board.game_over).to eq :winner
				end

				it 'returns winner when diagonal has all same objects' do
					grid = [
						[x_cell, x_cell, empty],
						[o_cell, x_cell, o_cell],
						[empty, o_cell, x_cell]
					]
					board = Board.new(grid: grid)
					expect(board.game_over).to eq :winner
				end

				it 'returns draw when all spaces are taken' do
					grid = [
						[o_cell, x_cell, o_cell],
						[o_cell, x_cell, o_cell],
						[x_cell, o_cell, x_cell]
					]
					board = Board.new(grid: grid)
					expect(board.game_over).to eq :draw
				end


				it 'returns false when game still on play' do
					grid = [
						[x_cell, empty, empty],
						[o_cell, empty, empty],
						[empty, empty, x_cell]
					]
					board = Board.new(grid: grid)
					expect(board.game_over).to eq false
				end
			end
		end
	end
end