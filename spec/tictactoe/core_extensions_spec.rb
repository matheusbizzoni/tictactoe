module Tictactoe 
	RSpec.describe Array do
		context '#all_empty?' do
			it 'returns true if all elements are empty' do
				expect(['', ''].all_empty?).to be_truthy
			end
			it 'returns true if array is empty' do
				expect([].all_empty?).to be_truthy
			end
			it 'returns false if array is not empty' do
				expect(['2',''].all_empty?).to be_falsey
			end
		end

		context '#all_same?' do 
			it 'returns true if all elements are the same' do
				expect(['test','test'].all_same?).to be_truthy
			end
			it 'returns true if array is empty' do
				expect([].all_same?).to be_truthy
			end
			it 'returns false if there is an different element' do
				expect(['test','test', ''].all_same?).to be_falsey
			end
		end

		context '#any_empty?' do 
			it 'returns false if there is no empty element' do
				expect(['test','test'].any_empty?).to be_falsey
			end
			it 'returns true if there is an empty element' do
				expect(['test','test', ''].any_empty?).to be_truthy
			end
			it 'returns true if all elements are empty' do
				expect(['','', ''].any_empty?).to be_truthy
			end
		end

		context '#none_empty?' do 
			it 'returns true if there is no empty element' do
				expect(['test','test'].none_empty?).to be_truthy
			end		
			it 'returns false if there is an empty element' do
				expect(['test','test', ''].none_empty?).to be_falsey
			end
			it 'returns false if all elements are empty' do
				expect(['','', ''].none_empty?).to be_falsey
			end
		end
	end
end