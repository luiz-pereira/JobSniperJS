class Include < ApplicationRecord
	belongs_to :request

	def self.delete_includes(includes_array)
		includes_array.each do |include|
			self.find(include).destroy
		end
	end

end
