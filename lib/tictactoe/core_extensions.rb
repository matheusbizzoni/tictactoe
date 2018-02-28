class Array
	def all_empty?
		self.all? { |e| e.to_s.empty? }
	end

	def all_same?
		self.all? { |e| e.to_s == self[0].to_s }
	end

	def any_empty?
		self.any? { |e| e.to_s.empty? }
	end

	def none_empty?
		!any_empty?
	end
end	