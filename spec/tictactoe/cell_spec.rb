module Tictactoe
	RSpec.describe Cell do
		context '#initialize' do 
			it 'is initialized with default value' do
				cell = Cell.new
				expect(cell.value).to eq ''
			end

			it "can be initialized with a value of 'X'" do
				cell = Cell.new('X')
				expect(cell.value).to eq 'X'
			end
 		end
	end
end