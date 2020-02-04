class Include < ApplicationRecord
	belongs_to :request, autosave: true

	def self.delete_includes(includes_array)
		includes_array.each do |include|
			self.find(include).destroy
		end
	end

end
