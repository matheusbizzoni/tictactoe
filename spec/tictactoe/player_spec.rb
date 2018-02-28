module Tictactoe
	RSpec.describe Player do
		subject { Player.new(input) }
		let(:input) { { color: 'X', name: 'Player1', kind: :hum } }
		context '#initialize' do
			it 'raises an exception when initialized with {}' do
				expect { Player.new({}) }.to raise_error(KeyError)
			end

			it 'does not raise an error when initialized with a valid hash input' do
				expect { subject }.not_to raise_error
			end
		end

		context '#color' do
			it 'returns players color' do
				expect(subject.color).to eq 'X'
			end
		end

		context '#name' do
 			it 'returns players name' do
 				expect(subject.name).to eq "Player1"
 			end
		end

		context '#kind' do
 			it 'returns players kind' do
 				expect(subject.kind).to eq :hum
 			end
		end			
	end
end